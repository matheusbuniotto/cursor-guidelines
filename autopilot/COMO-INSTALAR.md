# Como instalar o Autopilot (membro do time de Analytics)

Guia mínimo para um membro do time instalar e começar a usar o Autopilot no Cursor.

---

## 1. Copiar o kit para o seu projeto dbt

**Opção A — Você tem o repo cursor-guidelines clonado**

```bash
# Na raiz do seu projeto dbt:
cp -r /caminho/para/cursor-guidelines/autopilot/.cursor .
```

**Opção B — Clonar só para copiar**

```bash
git clone https://github.com/matheusbuniotto/cursor-guidelines.git /tmp/cursor-guidelines
cp -r /tmp/cursor-guidelines/autopilot/.cursor /caminho/do/seu/projeto/dbt/
```

**Opção C — Pedir para uma IA instalar**

Abra o Cursor no seu projeto dbt, abra o Agent (Cmd+I / Ctrl+I) e digite:

> Siga este guia e instale o Autopilot para mim: https://github.com/matheusbuniotto/cursor-guidelines (pasta autopilot, copiar .cursor para este projeto)

A IA vai perguntar se é **só este projeto** ou **global**; escolha “este projeto” e ela copia o `.cursor/` para a raiz do seu projeto dbt.

---

## 2. Abrir o projeto no Cursor

Abra a pasta do **projeto dbt** no Cursor (File → Open Folder). O Autopilot usa os comandos que estão em `.cursor/` dentro dessa pasta.

---

## 3. Configurar uma vez: `/setup`

No chat do Cursor (Agent / Composer), digite:

```
/setup
```

O agente vai:

- Tentar preencher **nome e email** do GitHub (gh) ou do git; você só confirma ou edita.
- Pedir **revisor(es) do PR** (usernames do GitHub).
- Pedir **label do time** (ex.: equipe-analytics).
- Pedir **chave do projeto JIRA** (ex.: TSK) e **nome do status “Em revisão”** (ex.: Review).
- Perguntar se, após abrir o PR, deve perguntar se você quer **mover a tarefa para Review e comentar no JIRA**.

Isso gera o arquivo `.autopilot/config.json`. Se não quiser versionar, adicione ao `.gitignore`:

```
.autopilot/config.json
```

---

## 4. Usar no dia a dia

**Uma tarefa do início ao PR:**

```
/launch TSK-123
```

(Substitua `TSK-123` pelo ID da sua tarefa no JIRA.)

O agente faz: pull da tarefa → classifica → planeja (se precisar) → executa → review → abre PR. Depois pode perguntar se você quer mover a tarefa para Review e comentar no JIRA (resumo + link do PR).

**Passo a passo (se preferir):**

```
/pull TSK-123
/plan
/execute-plan
/review
/pr
```

**Ajuda:** digite `/help` para ver todos os comandos.

---

## 5. Resumo

| Passo | O que fazer |
|-------|-------------|
| 1 | Copiar `autopilot/.cursor/` para a raiz do seu projeto dbt (ou pedir para uma IA instalar). |
| 2 | Abrir o projeto dbt no Cursor. |
| 3 | Rodar `/setup` uma vez (nome, email, revisor, label, JIRA). |
| 4 | Rodar `/launch TSK-XXX` para uma tarefa (ou `/pull` → `/plan` → `/execute-plan` → `/review` → `/pr`). |

**Repo do kit:** https://github.com/matheusbuniotto/cursor-guidelines

**Dúvidas:** leia o [ONBOARDING.md](ONBOARDING.md) ou o [README.md](README.md) na pasta autopilot.
