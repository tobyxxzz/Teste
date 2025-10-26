# 🚀 Guia Completo de Uso - LuaAI

## 🎯 O que é o LuaAI?

O **LuaAI** é um sistema inteligente de análise de código Lua que funciona como seu assistente pessoal de programação. Ele analisa seu código, identifica problemas, sugere melhorias e oferece templates prontos.

## 📦 Instalação e Configuração

### Pré-requisitos
```bash
# Instale Lua no seu sistema
# Ubuntu/Debian:
sudo apt install lua5.1

# CentOS/RHEL/Fedora:
sudo yum install lua

# macOS:
brew install lua

# Windows: Baixe de https://www.lua.org/download.html
```

### Verificando a Instalação
```bash
lua -v
# Deve mostrar: Lua 5.1.5  Copyright (C) 1994-2012 Lua.org, PUC-Rio
```

## 🎮 Formas de Usar o LuaAI

### 1. 📊 Demonstração Completa
Execute o exemplo de demonstração para ver todas as funcionalidades:

```bash
lua exemplo_uso.lua
```

**O que você vai ver:**
- ✅ Análise completa de código
- 💡 Sugestões inteligentes
- ⚡ Otimizações de performance
- 🏗️ Templates de código
- 📋 Relatórios detalhados

### 2. 🖥️ Interface de Linha de Comando (CLI)

#### Modo Interativo
```bash
lua cli.lua
```

Comandos disponíveis:
```
> help                    # Lista todos comandos
> analyze arquivo.lua     # Analisa um arquivo
> check "print('test')"   # Verifica código inline
> suggest arquivo.lua     # Obtém sugestões
> template module         # Gera template
> quit                   # Sair
```

#### Comandos Diretos
```bash
# Analisa um arquivo específico
lua cli.lua analyze meu_script.lua

# Gera relatório completo
lua cli.lua report meu_script.lua

# Obtém sugestões
lua cli.lua suggest meu_script.lua

# Lista templates disponíveis
lua cli.lua templates

# Gera template de módulo
lua cli.lua template module
```

### 3. 🔧 Uso Programático

Integre o LuaAI diretamente no seu código:

```lua
-- Carrega o sistema
local LuaAI = require('lua_ai')

-- Cria instância
local ai = LuaAI:new()

-- Seu código para análise
local meu_codigo = [[
local function calcular(a, b)
    return a + b
end

local resultado = calcular(5, 3)
print(resultado)
]]

-- Analisa o código
local analysis = ai:analyze(meu_codigo)

-- Mostra o relatório
print(ai:generateReport(analysis))

-- Obtém sugestões específicas
local sugestoes = ai:getSuggestions(meu_codigo)
for i, sugestao in ipairs(sugestoes) do
    print(i .. ". " .. sugestao.message)
end
```

## 🎯 Casos de Uso Práticos

### 💼 Para Desenvolvedores Iniciantes

**Aprendendo Boas Práticas:**
```lua
-- Código com problemas (exemplo)
name = "João"  -- Variável global
function process()
    result = ""
    for i = 1, 1000 do
        result = result .. "item" .. i  -- Ineficiente
    end
end
```

**O LuaAI vai sugerir:**
- Tornar `name` uma variável local
- Usar `table.concat()` em vez de concatenação em loop
- Adicionar tratamento de erros
- Melhorar a documentação

### 🏢 Para Desenvolvedores Experientes

**Code Review Automático:**
```bash
# Analisa todos arquivos Lua de um projeto
for file in $(find . -name "*.lua"); do
    lua cli.lua report "$file" > "reports/$(basename $file).txt"
done
```

### 👥 Para Equipes de Desenvolvimento

**Padronização de Código:**
```lua
-- Use o LuaAI para garantir que todo código segue padrões
local LuaAI = require('lua_ai')
local ai = LuaAI:new()

-- Configure padrões da equipe
ai.config.analysis.enforce_local_vars = true
ai.config.analysis.max_function_length = 30
ai.config.performance.warn_string_concat_in_loops = true
```

## 📊 Tipos de Análise Oferecidos

### 1. 🔍 Análise de Sintaxe
- Verifica se o código está sintaticamente correto
- Identifica erros de sintaxe com localização precisa
- Sugere correções automáticas

### 2. 📏 Análise de Qualidade
- **Variáveis Globais**: Detecta uso acidental de globais
- **Complexidade**: Mede complexidade de funções
- **Tamanho**: Identifica funções muito longas
- **Comentários**: Sugere onde adicionar documentação

### 3. ⚡ Análise de Performance
- **String Concatenation**: Detecta concatenação ineficiente
- **Loop Optimization**: Identifica loops que podem ser otimizados
- **Global Access**: Avisa sobre acesso frequente a globais
- **Memory Usage**: Sugere otimizações de memória

### 4. 🏗️ Geração de Templates

#### Template de Módulo
```bash
lua cli.lua template module
```

Gera:
```lua
local MeuModulo = {}
MeuModulo.__index = MeuModulo

function MeuModulo:new(...)
    local instance = {}
    setmetatable(instance, MeuModulo)
    return instance
end

return MeuModulo
```

#### Template de Tratamento de Erros
```bash
lua cli.lua template error_handler
```

## 🔧 Configuração Avançada

Edite `config.lua` para personalizar:

```lua
local config = {
    analysis = {
        max_complexity = 10,           -- Complexidade máxima aceitável
        max_function_length = 50,      -- Linhas máximas por função
        enforce_local_vars = true,     -- Força uso de variáveis locais
        require_comments = false       -- Exige comentários
    },
    
    suggestions = {
        show_examples = true,          -- Mostra exemplos nas sugestões
        max_suggestions = 20,          -- Máximo de sugestões
        detailed_explanations = true   -- Explicações detalhadas
    },
    
    performance = {
        warn_string_concat_in_loops = true,  -- Avisa concatenação em loops
        warn_global_access = true,           -- Avisa acesso a globais
        suggest_local_caching = true         -- Sugere cache local
    },
    
    templates = {
        include_examples = true,       -- Inclui exemplos nos templates
        add_documentation = true       -- Adiciona docs automáticas
    }
}
```

## 📈 Interpretando os Relatórios

### Exemplo de Relatório Típico:
```
=== Relatório de Análise LuaAI ===

SINTAXE:
✓ Código sintaticamente correto

QUALIDADE:
• 3 variáveis globais detectadas (linhas 2, 5, 8)
• 1 função excede tamanho recomendado (linha 12)
• Faltam comentários em 2 funções

PERFORMANCE:
• Concatenação de strings em loop (linha 15)
• Acesso frequente a 'math.sin' (linha 23)

SUGESTÕES:
1. Torne 'resultado' uma variável local
2. Use table.concat() em vez de concatenação
3. Cache a referência para 'math.sin'

MÉTRICAS:
• Linhas de código: 45
• Funções: 3
• Complexidade: Baixa-Média
• Score de qualidade: 7.5/10
```

## 🔄 Workflow Recomendado

### Para Desenvolvimento Individual:
1. **Escreva** seu código normalmente
2. **Analise** com `lua cli.lua analyze arquivo.lua`
3. **Revise** as sugestões
4. **Aplique** as melhorias sugeridas
5. **Re-analise** para confirmar melhorias

### Para Code Review:
1. **Gere relatório** antes do commit
2. **Revise** problemas críticos
3. **Documente** decisões sobre sugestões ignoradas
4. **Compartilhe** relatório com a equipe

### Para CI/CD:
```bash
#!/bin/bash
# Script de CI para análise automática
echo "Executando análise LuaAI..."

failed=0
for file in $(find . -name "*.lua"); do
    echo "Analisando $file..."
    lua cli.lua analyze "$file" > "/tmp/report.txt"
    
    # Verifica se há erros críticos
    if grep -q "ERRO CRÍTICO" "/tmp/report.txt"; then
        echo "❌ Erro crítico encontrado em $file"
        failed=1
    fi
done

if [ $failed -eq 1 ]; then
    echo "❌ Build falhou devido a problemas no código"
    exit 1
else
    echo "✅ Análise concluída com sucesso"
fi
```

## 🎓 Dicas e Truques

### 1. 💡 Análise Rápida
```bash
# Para análise rápida de sintaxe
lua cli.lua check "local x = 5; print(x)"
```

### 2. 📋 Análise em Lote
```bash
# Crie script para analisar múltiplos arquivos
#!/bin/bash
for file in *.lua; do
    echo "=== $file ==="
    lua cli.lua suggest "$file"
    echo ""
done
```

### 3. 🔧 Integração com Editor
```lua
-- Plugin simples para editor
local LuaAI = require('lua_ai')
local ai = LuaAI:new()

function analyze_current_buffer()
    local code = get_buffer_content()  -- Função do seu editor
    local analysis = ai:analyze(code)
    
    -- Mostra sugestões
    show_popup(ai:generateReport(analysis))
end

-- Bind para tecla F5
bind_key("F5", analyze_current_buffer)
```

### 4. 📊 Métricas de Projeto
```lua
-- Script para métricas do projeto
local LuaAI = require('lua_ai')
local ai = LuaAI:new()

local total_files = 0
local total_suggestions = 0
local quality_scores = {}

-- Analisa todos arquivos
for file in io.popen("find . -name '*.lua'"):lines() do
    local f = io.open(file, "r")
    local code = f:read("*all")
    f:close()
    
    local analysis = ai:analyze(code)
    local suggestions = ai:getSuggestions(code)
    
    total_files = total_files + 1
    total_suggestions = total_suggestions + #suggestions
    table.insert(quality_scores, analysis.quality_score or 5)
end

-- Relatório final
print("=== Métricas do Projeto ===")
print("Arquivos analisados: " .. total_files)
print("Total de sugestões: " .. total_suggestions)
print("Média de qualidade: " .. (sum(quality_scores) / #quality_scores))
```

## 🆘 Resolução de Problemas

### ❌ "module 'lua_ai' not found"
```bash
# Certifique-se que está no diretório correto
cd /caminho/para/luaai
lua exemplo_uso.lua

# Ou configure o LUA_PATH
export LUA_PATH="./?.lua;$LUA_PATH"
```

### ⚠️ Performance lenta em arquivos grandes
```lua
-- Desabilite análise detalhada
local ai = LuaAI:new()
ai.config.analysis.detailed = false
ai.config.performance.deep_analysis = false
```

### 🔧 Customizar sugestões
```lua
-- Configure o que você quer analisar
local ai = LuaAI:new()
ai.config.suggestions.show_style_warnings = false
ai.config.suggestions.show_performance_tips = true
```

## 🎯 Próximos Passos

1. **Execute a demonstração**: `lua exemplo_uso.lua`
2. **Experimente o CLI**: `lua cli.lua`
3. **Analise seu próprio código**: `lua cli.lua analyze seu_arquivo.lua`
4. **Integre no seu workflow** de desenvolvimento
5. **Configure** de acordo com suas necessidades
6. **Compartilhe** com sua equipe

---

**🚀 Pronto para começar?** Execute `lua exemplo_uso.lua` e veja a mágica acontecer!

O LuaAI vai revolucionar seu desenvolvimento em Lua, tornando seu código mais limpo, eficiente e profissional. 

**💡 Dica final:** Use o LuaAI regularmente - quanto mais você usar, melhor será seu código Lua!
