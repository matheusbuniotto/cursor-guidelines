# Autopilot — Kit de Analytics Engineering para Cursor

O Autopilot reduz trabalho manual de AE em ambientes dbt grandes, executando tarefas repetitivas e bem escopadas de ponta a ponta. É **nativo do Cursor**: Commands, Agents e Skills ficam em `.cursor/` e funcionam com o Agent (Composer) do Cursor.

**Spec:** O comportamento completo está em **@docs** — `00_project_overview.md`, `01_task_classification.md`, `02_autopilot_commands.md`, `03_failures_git_state.md`.

**Equipe em PT-BR:** commits e PRs são feitos em **português brasileiro**. Os comandos e agentes já estão configurados para isso.

---

## Instalação (compartilhar e onboarding)

**Opção A — Instalação assistida por IA (recomendado para novos usuários)**

1. Envie para o Cursor ou qualquer IA: *"Siga este guia e instale o Autopilot para mim: [link deste repo ou autopilot/INSTALL.md]"*
2. A IA pergunta **Só este projeto ou global?** e copia o kit. As instruções completas para a IA estão em **[INSTALL.md](INSTALL.md)**.

**Opção B — Instalação por script**

Rode na raiz do repo: `./autopilot/install.sh` — pergunta **Projeto (diretório atual) ou Global (~/.cursor/)** e copia. Não interativo: `./autopilot/install.sh --project` ou `--global`.

**Opção C — Copiar manualmente no repo dbt**

1. Copie a pasta **`.cursor/`** deste diretório `autopilot/` para a **raiz do seu projeto dbt**.
2. No Cursor, abra o projeto dbt. Os comandos e skills ficam disponíveis na hora.
3. No chat, use **@docs** (anexe a pasta `docs/` do repo) para o agente ter a spec completa do Autopilot.

**Opção D — Clonar o repo inteiro**

1. Clone este repo.
2. No Cursor, **Arquivo → Abrir pasta** e abra o repo clonado (ou seu repo dbt com `autopilot/.cursor/` copiado).
3. Use **@docs** para anexar a pasta `docs/` da spec.

**Opção E — Repo compartilhado do time**

1. Crie um repo do time com `autopilot/.cursor/` (ou este repo completo).
2. Novos membros: clonam o repo e copiam `autopilot/.cursor/` para a raiz do projeto dbt.
3. Documente no wiki do time: "Copie `autopilot/.cursor/` para o repo dbt; no Cursor use @docs para a spec."

---

## Início rápido

1. **Um comando (padrão):** No chat do Cursor, digite `/launch TSK-123` (substitua pelo ID da tarefa JIRA).  
   O agente roda: pull → plan → execute-plan → review → pr.

2. **Passo a passo:**  
   - `/pull TSK-123` — Busca tarefa, sincroniza branch de release, cria branch `TSK-123`.  
   - `/plan` — Classifica (L0–L3), gera plano se necessário.  
   - `/execute-plan` — Executa o trabalho (use `--phase=1` ou `--all` para L3).  
   - `/review` — Roda dbt build/testes; bloqueia PR se houver falhas.  
   - `/pr` — Abre PR (template); o Autopilot nunca faz merge.

3. **Config (onboarding):** `/setup` — Cria/atualiza `.autopilot/config.json` com nome, email, revisor(es) do PR, label do time, projeto/board JIRA e se, após abrir o PR, deve perguntar se move a tarefa para Review e comenta no JIRA. **Nome e email** podem ser preenchidos automaticamente a partir do **gh** (GitHub CLI), do **git config** ou do **GitHub MCP**, se disponíveis. Rode uma vez (ou quando mudar).

4. **Ajuda:** `/help` — Mostra a referência de comandos.

---

## O que tem dentro de `.cursor/`

| Pasta      | Conteúdo |
|------------|----------|
| `commands/` | `setup`, `pull`, `plan`, `execute-plan`, `review`, `pr`, `launch`, `help` — comandos slash. |
| `agents/`   | `classifier`, `planner`, `executor`, `verifier` — subagentes que o Agent pode delegar. |
| `skills/`   | `task-pull`, `classification`, `dbt-validate`, `pr-template` — skills reutilizáveis para tarefa, classificação, validação, PR. |
| `rules/`    | `autopilot.mdc` — guardrails (sem `git add .`, uma tarefa uma branch, PR é contrato, nunca merge); aplicado ao editar SQL/models ou `.autopilot/`. |

Todos os comandos e skills referenciam **@docs** para a spec completa (princípios, regras de Git, modos de falha, estado).

---

## Config (contexto do usuário)

O **`.autopilot/config.json`** guarda contexto de onboarding (nome, email, revisor do PR, label do time, JIRA). É criado/atualizado pelo comando **`/setup`**. Campos principais:

- **user.name**, **user.email** — usados em commits (e em `/pull` para configurar git no repo).
- **pr.default_reviewers**, **pr.team_label** — usados em `/pr` (revisores e label).
- **jira.project_key**, **jira.board_id**, **jira.review_status** — para referência; **jira.comment_after_pr** — se após abrir o PR devemos perguntar se move a tarefa para Review e comenta no JIRA (resumo + link do PR em PT-BR).

Exemplo de schema: **`autopilot/config.example.json`** no repo. Se não quiser versionar dados pessoais, adicione `.autopilot/config.json` ao `.gitignore`.

**Após abrir o PR:** Se configurado (ou por padrão), o agente pergunta: "Deseja que eu mova a tarefa JIRA para Review e comente na tarefa o que foi feito + link do PR?" Se sim, usa JIRA API/MCP se disponível; senão, entrega o texto do comentário (PT-BR) para o usuário colar manualmente.

---

## Template de PR, guia de SQL e outros guias

**Ficam no repo do seu projeto dbt**, não neste kit. O Autopilot lê do workspace quando você roda `/pr` ou `/review`. Coloque no repo dbt, por exemplo:

- **Template de PR:** `.github/PULL_REQUEST_TEMPLATE.md` ou `docs/pr-template.md`
- **Guia de estilo SQL:** `docs/sql-style.md` (ou similar)
- **Linter/config:** ex.: `.sqlfluff`, docs do projeto

Se existirem, o agente usa; se não, usa a estrutura padrão.

---

## Regras (de @docs)

- **Git:** Nunca `git add .`; sempre stage paths explícitos. Uma tarefa → uma branch; nome da branch = ID da tarefa.
- **PR:** O PR é o contrato; o Autopilot nunca faz merge; aprovação humana obrigatória.
- **Paradas:** Em ambiguidade, falha ou confirmação faltando — pare e persista estado em `.autopilot/`.
- **Idioma:** Commits e PRs sempre em **PT-BR** (português brasileiro).

---

## Artefatos

O Autopilot escreve em `.autopilot/` (crie se não existir):

- `config.json` — Criado/atualizado por `/setup` (nome, email, revisor, label, JIRA). Opcional; muitas vezes no `.gitignore`.
- `task.json` — Após pull (metadados da tarefa).
- `classification.json` — Após plan (L0–L3, rationale).
- `state.json` — Progresso, commits, resumo, estágio.
- `plan.yml` — Só para tarefas L2/L3.

Adicione `.autopilot/` (ou só `.autopilot/config.json`) ao `.gitignore` se preferir não versionar estado/dados pessoais (opcional).

---

## Checklist de onboarding (para o time)

- [ ] Copiar `autopilot/.cursor/` para a raiz do projeto dbt.
- [ ] No Cursor, abrir o projeto dbt e digitar `/help` para confirmar que os comandos aparecem.
- [ ] Rodar **`/setup`** para criar `.autopilot/config.json` (nome, email, revisor, label, JIRA). Ver `config.example.json` no repo.
- [ ] Anexar **@docs** (pasta `docs/` do repo) no chat ao usar o Autopilot para o agente ter a spec.
- [ ] Rodar `/launch TSK-XXX` uma vez com uma tarefa real ou de teste para validar o fluxo.
- [ ] Garantir que JIRA (ou entrada manual de tarefa), Git e dbt estão disponíveis no ambiente.
