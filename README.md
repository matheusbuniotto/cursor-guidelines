# Cursor Guidelines

Referência e exemplos para **Autopilot** (automação de Analytics Engineering) e fluxos baseados em Cursor (Skills, Agents, Commands).

**No chat do Cursor, use: `@docs`** para anexar a especificação.

---

## O que estamos construindo (fonte da verdade: @docs)

O sistema desejado está descrito na pasta `docs/`. Leia nesta ordem:

| Doc | Conteúdo |
|-----|----------|
| [docs/00_project_overview.md](docs/00_project_overview.md) | Propósito do Autopilot, princípios, fluxo JIRA → Git → dbt → PR, o que *não* fazemos |
| [docs/01_task_classification.md](docs/01_task_classification.md) | Níveis de tarefa L0–L3, árvore de decisão, regras Silver, profundidade de planejamento |
| [docs/02_autopilot_commands.md](docs/02_autopilot_commands.md) | Comandos: `pull`, `plan`, `execute-plan`, `review`, `pr`, `launch`; comportamento e artefatos |
| [docs/03_failures_git_state.md](docs/03_failures_git_state.md) | Modos de falha, regras de Git (sem `git add .`), arquivo de estado, práticas de PR |
| [docs/references_repos.md](docs/references_repos.md) | Resumo Cursor/Rules/Skills/Agents/Commands + GSD, Ralph, repositórios relacionados |

---

## Kit Autopilot (instalação e onboarding)

Fluxo de **Analytics Engineering** para Cursor: JIRA → Git → dbt → PR. Adaptado do GSD (Commands, Agents, Skills).

**Equipe em PT-BR:** commits e PRs são feitos em **português brasileiro** (títulos, descrições, mensagens de commit). Os agentes e comandos já estão configurados para isso.

| Passo | Ação |
|-------|------|
| **Instalar** | **IA:** Envie *"Siga este guia e instale o Autopilot para mim: [link do repo ou autopilot/INSTALL.md]"* — a IA pergunta projeto vs global e copia. **Script:** `./autopilot/install.sh` (interativo) ou `--project` / `--global`. **Manual:** Copie [autopilot/.cursor/](autopilot/.cursor/) para a raiz do seu projeto dbt ou para `~/.cursor/`. |
| **Usar** | No chat do Cursor: `/launch TSK-123` (fluxo completo) ou `/pull`, `/plan`, `/execute-plan`, `/review`, `/pr` passo a passo. |
| **Spec** | Anexe **@docs** no chat para o agente ter a especificação completa. |

- **[autopilot/INSTALL.md](autopilot/INSTALL.md)** — Guia de instalação para IA: cole o link no Cursor/qualquer IA; a IA pergunta projeto vs global e instala. Também documenta o script e como o GSD faz.
- **[autopilot/install.sh](autopilot/install.sh)** — Script: pergunta projeto (diretório atual) ou global (~/.cursor/), depois copia e mescla `.cursor/`. Não interativo: `--project` / `--global`.
- **[autopilot/README.md](autopilot/README.md)** — Opções de instalação (IA, script, manual), início rápido, artefatos, regras.
- **[autopilot/ONBOARDING.md](autopilot/ONBOARDING.md)** — Onboarding de 5 min para novos membros (copiar `.cursor/`, primeira tarefa, regras).

**Compartilhar com o time:** Envie o link **[autopilot/COMO-INSTALAR.md](autopilot/COMO-INSTALAR.md)** — guia mínimo em PT-BR: copiar `.cursor/` → abrir no Cursor → `/setup` → `/launch TSK-XXX`. Ou [autopilot/INSTALL.md](autopilot/INSTALL.md) para instalação assistida por IA; [autopilot/ONBOARDING.md](autopilot/ONBOARDING.md) para detalhes.

---

## Outros conteúdos

- **[docs/CURSOR-DOCS-GUIDE.md](docs/CURSOR-DOCS-GUIDE.md)** — Referência da plataforma Cursor: Commands, Skills, Subagents (caminhos e formatos em `.cursor/`).

- **[examples/gsd-bare-bones/](examples/gsd-bare-bones/)** — Exemplo mínimo no estilo GSD para Cursor (define → plan → execute). Modelo estrutural; o Autopilot é a aplicação de AE (JIRA, dbt, PR).
