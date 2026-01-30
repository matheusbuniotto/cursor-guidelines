# Autopilot — Onboarding (5 min)

Para **Analytics Engineers** que entram em um time que usa Autopilot com Cursor.

**Idioma:** commits e PRs são feitos em **português brasileiro (PT-BR)**. Os comandos e agentes já estão configurados para isso.

---

## 1. Instalar

Copie a pasta **`.cursor/`** do diretório `autopilot/` para a **raiz do seu projeto dbt**.

```
seu-projeto-dbt/
├── .cursor/          ← colar aqui (commands, agents, skills)
│   ├── commands/
│   ├── agents/
│   └── skills/
├── models/
├── dbt_project.yml
└── ...
```

Sem npm, sem CLI — só Cursor e essa pasta.

---

## 2. Configurar contexto (uma vez)

Rode **`/ae-autopilot:setup`** no chat do Cursor. O agente tenta preencher **nome e email** automaticamente a partir do **gh** (GitHub CLI) ou do **GitHub MCP**; se encontrar, pergunta se você quer usar ou editar. Senão, pede:

- **Nome e email** — para commits (git user.name / user.email)
- **Revisor(es) padrão do PR** — usernames do GitHub
- **Label do time** — para o PR (ex.: equipe-analytics)
- **Chave do projeto JIRA** — ex.: TSK
- **Status JIRA "Em revisão"** — ex.: Review
- **Após abrir PR, perguntar se move a tarefa para Review e comenta no JIRA?** — sim/não

Isso gera o arquivo **`.autopilot/config.json`** no projeto. Se não quiser versionar dados pessoais, adicione `.autopilot/config.json` ao `.gitignore`. Ver `autopilot/config.example.json` no repo para o schema.

---

## 3. Usar no Cursor

1. Abra o projeto dbt no Cursor.
2. Abra o Agent (Composer): **Cmd+I** (Mac) ou **Ctrl+I** (Windows/Linux).
3. No chat, digite **`/`** — você deve ver: `setup`, `pull`, `plan`, `execute-plan`, `review`, `pr`, `launch`, `help`.
4. **Anexar a spec:** Se o time mantém a spec do Autopilot numa pasta `docs/`, digite **@docs** e selecione essa pasta para o agente ter as regras completas (Git, PR, classificação).

---

## 4. Rodar a primeira tarefa

**Fluxo completo (um comando):**

```
/ae-autopilot:launch TSK-123
```

Substitua `TSK-123` pelo ID da tarefa no JIRA. O agente vai: pull → classificar → planejar (se precisar) → executar → review → abrir PR. **Título e descrição do PR e mensagens de commit serão em PT-BR.**  
Após abrir o PR, o agente pode perguntar se você quer **mover a tarefa JIRA para Review** e **comentar na tarefa** o que foi feito + link do PR (se configurado em `/ae-autopilot:setup`).

**Passo a passo (se preferir):**

```
/ae-autopilot:pull TSK-123
/ae-autopilot:plan
/ae-autopilot:execute-plan
/ae-autopilot:review
/ae-autopilot:pr
```

---

## 5. Template de PR, guia de SQL e outros guias

**Ficam no repo do seu projeto dbt.** Coloque no mesmo repo onde você roda o Autopilot, por exemplo:

- **Template de PR:** `.github/PULL_REQUEST_TEMPLATE.md` ou `docs/pr-template.md`
- **Guia de estilo SQL:** `docs/sql-style.md`
- **Linter/config:** ex.: `.sqlfluff`

O Autopilot usa quando você roda `/ae-autopilot:pr` ou `/ae-autopilot:review`; se não existir, usa um fallback.

---

## 6. Regras para lembrar

- **Uma tarefa → uma branch.** Nome da branch = ID da tarefa (ex.: `TSK-123`).
- **Nunca `git add .`** — o agente faz stage só de arquivos explícitos.
- **PR é o contrato.** O Autopilot abre o PR; um humano aprova e faz merge.
- **Commits e PR em PT-BR** — mensagens de commit, título e descrição do PR em português brasileiro.
- **Se algo falhar** — o agente para e reporta; corrija e rode de novo o passo.

---

## 7. Onde está a spec completa?

A spec completa do Autopilot (princípios, classificação L0–L3, regras de Git, modos de falha) fica em **@docs** neste repo:

- `00_project_overview.md`
- `01_task_classification.md`
- `02_autopilot_commands.md`
- `03_failures_git_state.md`

Use **@docs** no chat do Cursor ao trabalhar com o Autopilot para o agente ter o contexto completo.

---

## 8. Precisa de ajuda?

- Rode **`/ae-autopilot:help`** no chat para a referência de comandos.
- Leia o **README.md** na pasta `autopilot/` para opções de instalação e artefatos.
- Pergunte ao time o link da pasta `docs/` ou do repo que contém a spec.
