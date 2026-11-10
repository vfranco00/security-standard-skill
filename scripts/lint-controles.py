#!/usr/bin/env python3
"""Confere os blocos de controle do catálogo (formato em docs/formato-dos-controles.md).

Uso: python3 scripts/lint-controles.py [arquivos...]
Sem argumentos, confere todos os skills/*/references/controles-*.md.
Imprime ERRO <id>: <motivo> (arquivo:linha) e sai com 1, ou <n> controles válidos e sai com 0.
Só usa a biblioteca padrão do Python 3.
"""

import datetime
import re
import sys
import unicodedata
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
FAMILIAS = ["IAM", "DAT", "DEV", "OPS", "IRC", "GOV"]
CAMPOS = ["Enunciado", "Nível mínimo", "Perfis", "Parâmetro", "Por quê", "Fontes",
          "Como verificar", "Como implementar", "Evidência", "Mapa"]
NIVEIS = ["Essencial", "Fornecedor", "Big tech"]
PERFIS = ["financeiro", "seguros", "setor-publico", "cartoes", "saude"]
TIPOS = ["primária", "secundária", "proposta"]
MAPA = ["CAIQ", "SIG", "ISO", "SOC2", "CSF", "CIS", "ASVS"]

# No Markdown, até 3 espaços antes dos # ainda fazem um título.
TITULO = re.compile(r"^ {0,3}#{1,3}\s")
CERQUILHAS = re.compile(r"^ {0,3}#+")
CAMPO = re.compile(r"^- \*\*(.+?):\*\*\s*(.*)$")
ID = re.compile(r"^[A-Z]{3}-\d{2}$")
ID_NO_INICIO = re.compile(r"^[A-Z]{3}-\d{2}")
URL = re.compile(r"^https?://\S+$")
DATA = re.compile(r"^conferida em (\d{4}-\d{2}-\d{2})$")


def arquivos_padrao():
    """Os arquivos de controles de todas as skills, em ordem de caminho, com o rótulo relativo à raiz."""
    return [(p, str(p.relative_to(RAIZ))) for p in sorted(RAIZ.glob("skills/*/references/controles-*.md"))]


def ler(texto, rotulo):
    """Separa os blocos de controle do texto; cada bloco guarda os campos na ordem em que aparecem.

    Abre um bloco a linha que começa com "### " e todo título cujo primeiro token é um id
    (AAA-00), mesmo com outro nível, outro espaço ou de 1 a 3 espaços antes dos #: esse vira
    erro de cabeçalho, em vez de sumir com os campos. Outro título de nível 1 a 3, também com até
    3 espaços antes, fecha o bloco anterior. Linha recuada continua o campo de cima; dentro de
    Fontes, cada linha recuada que começa com "- " é uma fonte.
    """
    blocos = []
    bloco = campo = None
    for numero, linha in enumerate(texto.splitlines(), 1):
        cerquilhas = CERQUILHAS.match(linha)
        partes = linha[cerquilhas.end():].split(None, 1) if cerquilhas else []
        if linha.startswith("### ") or (partes and ID_NO_INICIO.match(partes[0])):
            resto = partes[1] if len(partes) > 1 else ""
            bloco = {
                "id": partes[0] if partes else "(sem id)",
                "titulo": resto[2:].strip() if resto.startswith("— ") else "",
                "cabecalho": linha.startswith("### "),
                "arquivo": rotulo,
                "linha": numero,
                "ordem": [],
                "campos": {},
                "fontes": [],
                "soltas": [],
            }
            blocos.append(bloco)
            campo = None
            continue
        if TITULO.match(linha):
            bloco = campo = None
            continue
        if bloco is None or not linha.strip():
            continue
        achado = CAMPO.match(linha)
        if achado:
            campo = achado.group(1)
            bloco["ordem"].append(campo)
            bloco["campos"].setdefault(campo, achado.group(2).strip())
        elif linha[0] in " \t" and campo is not None:
            trecho = linha.strip()
            if campo != "Fontes":
                bloco["campos"][campo] = (bloco["campos"][campo] + " " + trecho).strip()
            elif trecho.startswith("- "):
                bloco["fontes"].append(trecho[2:].strip())
            elif bloco["fontes"]:
                bloco["fontes"][-1] += " " + trecho
            else:
                bloco["soltas"].append(numero)
        else:
            bloco["soltas"].append(numero)
    return blocos


def ler_mapa(texto):
    """Os pares do campo Mapa, ou None se as chaves não forem as sete, nesta ordem, com valor."""
    pares = [parte.partition(":") for parte in texto.split(";")]
    chaves = [chave.strip() for chave, _, _ in pares]
    valores = [valor.strip() for _, _, valor in pares]
    if chaves != MAPA or not all(valores) or not all(separador for _, separador, _ in pares):
        return None
    return dict(zip(chaves, valores))


def data_existe(aaaa_mm_dd):
    try:
        datetime.date.fromisoformat(aaaa_mm_dd)
    except ValueError:
        return False
    return True


def conferir_bloco(bloco, vistos, proximo):
    """Os erros de um bloco. vistos guarda onde cada id apareceu; proximo, o número esperado por família."""
    erros = []
    id_ = bloco["id"]
    onde = f"{bloco['arquivo']}:{bloco['linha']}"

    def erro(motivo):
        erros.append(f"ERRO {id_}: {motivo} ({onde})")

    if not bloco["cabecalho"] or not bloco["titulo"]:
        erro('cabeçalho fora do formato "### AAA-00 — Título" (três #, um espaço comum, o id, " — " e o título)')
    if not ID.match(id_):
        erro("id fora do padrão AAA-00 (três letras maiúsculas, hífen e dois dígitos)")
    elif id_[:3] not in FAMILIAS:
        erro(f"família {id_[:3]} fora das seis ({', '.join(FAMILIAS)})")
    elif id_ in vistos:
        erro(f"id repetido (já em {vistos[id_]})")
    else:
        vistos[id_] = onde
        familia, numero = id_[:3], int(id_[4:])
        esperado = proximo.get(familia, 1)
        if numero != esperado:
            erro(f"fora da sequência da família {familia} (esperado: {familia}-{esperado:02d})")
        proximo[familia] = numero + 1

    for numero in bloco["soltas"]:
        erro(f"linha fora de um campo na linha {numero}: o campo começa com '- **Nome:** ' e a continuação vai recuada")
    ordem = bloco["ordem"]
    for nome in dict.fromkeys(ordem):
        if nome not in CAMPOS:
            erro(f"campo desconhecido: {nome}")
    for nome in CAMPOS:
        if nome not in ordem:
            erro(f"falta o campo {nome}")
        elif ordem.count(nome) > 1:
            erro(f"campo repetido: {nome}")
    presentes = [nome for nome in dict.fromkeys(ordem) if nome in CAMPOS]
    if presentes != [nome for nome in CAMPOS if nome in presentes]:
        erro("campos fora da ordem (a ordem é: " + ", ".join(CAMPOS) + ")")

    campos = bloco["campos"]
    for nome in CAMPOS:
        if nome != "Fontes" and nome in campos and not campos[nome]:
            erro(f"campo {nome} vazio")
    nivel = campos.get("Nível mínimo")
    if nivel and nivel not in NIVEIS:
        erro(f'nível mínimo "{nivel}" fora do conjunto ({", ".join(NIVEIS)})')
    perfis = campos.get("Perfis")
    if perfis and perfis != "todos":
        itens = [item.strip() for item in perfis.split(",")]
        if any(item not in PERFIS for item in itens) or len(set(itens)) != len(itens):
            erro(f'perfis "{perfis}" fora do conjunto (todos, ou lista separada por vírgula de: {", ".join(PERFIS)})')
    if "Fontes" in campos:
        tipos = []
        if not bloco["fontes"]:
            erro("Fontes sem nenhuma fonte (uma por linha recuada: tipo — título — URL — conferida em AAAA-MM-DD)")
        for i, fonte in enumerate(bloco["fontes"], 1):
            partes = [parte.strip() for parte in fonte.split(" — ")]
            if len(partes) < 4:
                erro(f'fonte {i} fora do formato "tipo — título — URL — conferida em AAAA-MM-DD"')
                continue
            tipo, titulo, url, data = partes[0], " — ".join(partes[1:-2]), partes[-2], partes[-1]
            tipos.append(tipo)
            if tipo not in TIPOS:
                erro(f'fonte {i}: tipo "{tipo}" fora do conjunto ({", ".join(TIPOS)})')
            if not titulo:
                erro(f"fonte {i}: sem título")
            if not URL.match(url):
                erro(f'fonte {i}: URL "{url}" não começa com http:// ou https://')
            achado = DATA.match(data)
            if not achado:
                erro(f'fonte {i}: data "{data}" fora do formato "conferida em AAAA-MM-DD"')
            elif not data_existe(achado.group(1)):
                erro(f'fonte {i}: data "{achado.group(1)}" não existe')
        if tipos and "primária" not in tipos and not campos.get("Parâmetro", "").endswith("(proposta)"):
            erro("sem fonte primária, o Parâmetro tem de terminar com (proposta)")
    mapa = campos.get("Mapa")
    if mapa and ler_mapa(mapa) is None:
        erro('Mapa fora do formato "' + "; ".join(f"{chave}: ..." for chave in MAPA) + '" (— onde não houver)')
    return erros


def conferir(arquivos):
    """Lê e confere os arquivos (pares caminho, rótulo); devolve os blocos e a lista de erros."""
    blocos, erros = [], []
    for caminho, rotulo in arquivos:
        if caminho.is_dir():
            erros.append(f"ERRO {rotulo}: é uma pasta; passe os arquivos controles-*.md")
            continue
        if not caminho.is_file():
            erros.append(f"ERRO {rotulo}: arquivo não encontrado")
            continue
        try:
            texto = caminho.read_text(encoding="utf-8-sig")  # tira o BOM, se houver
        except UnicodeDecodeError:
            erros.append(f"ERRO {rotulo}: não é UTF-8")
            continue
        lidos = ler(unicodedata.normalize("NFC", texto), rotulo)
        if not lidos:
            erros.append(f"ERRO {rotulo}: nenhum bloco de controle (### AAA-00 — Título)")
        blocos += lidos
    vistos, proximo = {}, {}
    for bloco in blocos:
        erros += conferir_bloco(bloco, vistos, proximo)
    return blocos, erros


def main(argumentos):
    arquivos = [(Path(a), a) for a in argumentos] if argumentos else arquivos_padrao()
    blocos, erros = conferir(arquivos)
    if erros:
        print("\n".join(erros))
        return 1
    print(f"{len(blocos)} controles válidos")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
