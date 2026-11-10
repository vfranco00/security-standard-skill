#!/usr/bin/env python3
"""Gera docs/catalogo-de-controles.md e docs/mapa-de-frameworks.md a partir dos blocos de controle.

Uso: python3 scripts/gerar-catalogo.py
Lê skills/*/references/controles-*.md e confere os blocos com o lint-controles.py; se houver erro,
mostra os erros e não escreve nada. Mesma entrada, mesma saída: nada de data nem de ordem do sistema.
Só usa a biblioteca padrão do Python 3.
"""

import importlib.util
import sys
from pathlib import Path

# Importar o linter não deixa scripts/__pycache__ no repositório.
sys.dont_write_bytecode = True
_spec = importlib.util.spec_from_file_location("lint_controles", Path(__file__).resolve().parent / "lint-controles.py")
lint = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(lint)

AVISO = ("> Gerado por `scripts/gerar-catalogo.py` a partir de `skills/*/references/controles-*.md`. "
         "Não edite à mão: mude o bloco do controle e rode o script de novo.")
VERSOES = ("CCM/CAIQ v4.1; SIG 2026 (só domínios); ISO/IEC 27001:2022 com a Amd 1:2024; "
           "SOC 2 TSC 2017 (pontos de foco de 2022); NIST CSF 2.0; CIS Controls v8.1; OWASP ASVS 5.0.")
# A mesma frase de docs/formato-dos-controles.md ("Versões do Mapa").
TRACO = ("Nas chaves SOC2 e SIG, `—` quer dizer \"não conferido em fonte oficial gratuita nesta versão\", "
         "e não só \"não há correspondente\"; os ids da ISO/IEC 27001 foram conferidos pela OLIR 155 do NIST.")


def linha(*celulas):
    return "| " + " | ".join(str(celula).replace("|", "\\|") for celula in celulas) + " |"


def separador(colunas):
    return "|" + "---|" * colunas


def familia(bloco):
    return bloco["id"][:3]


def ordem(bloco):
    """Famílias na ordem das skills (o linter já barrou família fora das seis); dentro delas, pelo id."""
    return (lint.FAMILIAS.index(familia(bloco)), bloco["id"])


def skill(bloco):
    """A pasta da skill dona, tirada de skills/<skill>/references/controles-*.md."""
    return Path(bloco["arquivo"]).parts[1]


def catalogo(blocos):
    familias = list(dict.fromkeys(familia(b) for b in blocos))
    saida = [
        "# Catálogo de controles", "", AVISO, "",
        "## Contagem por nível", "",
        "Os níveis são cumulativos: quem mira o Fornecedor atende os controles Essencial e Fornecedor; "
        "quem mira o Big tech atende todos.", "",
        linha("Família", *lint.NIVEIS, "Total"), separador(len(lint.NIVEIS) + 2),
    ]
    total = [0] * len(lint.NIVEIS)
    for f in familias:
        contagem = [sum(1 for b in blocos if familia(b) == f and b["campos"]["Nível mínimo"] == nivel)
                    for nivel in lint.NIVEIS]
        total = [t + c for t, c in zip(total, contagem)]
        saida.append(linha(f, *contagem, sum(contagem)))
    saida.append(linha("**Total**", *total, sum(total)))
    saida.append(linha("**Acumulado**", *(sum(total[:i + 1]) for i in range(len(total))), "—"))
    for f in familias:
        saida += ["", f"## {f}", "",
                  linha("Id", "Título", "Nível mínimo", "Perfis", "Parâmetro", "Skill"), separador(6)]
        for b in blocos:
            if familia(b) == f:
                campos = b["campos"]
                saida.append(linha(b["id"], b["titulo"], campos["Nível mínimo"], campos["Perfis"],
                                   campos["Parâmetro"], skill(b)))
    return "\n".join(saida) + "\n"


def mapa(blocos):
    saida = [
        "# Mapa de frameworks", "", AVISO, "",
        "Só identificadores e títulos curtos, nenhum texto dos frameworks; `—` quando o controle não tem "
        "correspondente. Versões: " + VERSOES + " " + TRACO, "",
        linha("Id", *lint.MAPA), separador(len(lint.MAPA) + 1),
    ]
    for b in blocos:
        valores = lint.ler_mapa(b["campos"]["Mapa"])
        saida.append(linha(b["id"], *(valores[chave] for chave in lint.MAPA)))
    return "\n".join(saida) + "\n"


def escrever(caminho, texto):
    with open(caminho, "w", encoding="utf-8", newline="\n") as arquivo:
        arquivo.write(texto)


def main():
    blocos, erros = lint.conferir(lint.arquivos_padrao())
    if erros:
        print("\n".join(erros))
        print("catálogo não gerado: corrija os erros acima")
        return 1
    blocos.sort(key=ordem)
    docs = lint.RAIZ / "docs"
    docs.mkdir(exist_ok=True)
    escrever(docs / "catalogo-de-controles.md", catalogo(blocos))
    escrever(docs / "mapa-de-frameworks.md", mapa(blocos))
    print(f"docs/catalogo-de-controles.md e docs/mapa-de-frameworks.md gerados com {len(blocos)} controles")
    return 0


if __name__ == "__main__":
    sys.exit(main())
