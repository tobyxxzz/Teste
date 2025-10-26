#!/usr/bin/env lua

--[[
    LuaAI - Sistema de Inteligência Artificial para Programação Lua
    
    Este sistema oferece:
    - Análise de código Lua
    - Sugestões de melhores práticas
    - Detecção de erros comuns
    - Otimizações de performance
    - Templates de código
    
    Versão: 1.0
    Autor: LuaAI System
--]]

local LuaAI = {}
LuaAI.__index = LuaAI

-- Módulos internos
local CodeAnalyzer = {}
local SuggestionEngine = {}
local PatternDetector = {}
local PerformanceAnalyzer = {}

-- Inicialização do sistema
function LuaAI:new()
    local instance = {
        version = "1.0.0",
        patterns = {},
        suggestions = {},
        errors = {},
        optimizations = {},
        templates = {}
    }
    setmetatable(instance, LuaAI)
    instance:loadPatterns()
    instance:loadTemplates()
    return instance
end

-- Carrega padrões de código conhecidos
function LuaAI:loadPatterns()
    self.patterns = {
        -- Padrões comuns em Lua
        bad_practices = {
            "global_vars", "unused_vars", "deep_nesting", 
            "long_functions", "magic_numbers", "no_comments"
        },
        
        good_practices = {
            "local_vars", "descriptive_names", "modular_code",
            "error_handling", "documentation", "consistent_style"
        },
        
        performance_issues = {
            "string_concatenation", "table_access", "global_access",
            "recursive_depth", "memory_leaks", "inefficient_loops"
        }
    }
end

-- Carrega templates de código
function LuaAI:loadTemplates()
    self.templates = {
        module = [[
-- Módulo: %s
local %s = {}
%s.__index = %s

function %s:new(...)
    local instance = {}
    setmetatable(instance, %s)
    return instance
end

return %s
]],
        
        class = [[
-- Classe: %s
local %s = {}
%s.__index = %s

function %s:new(...)
    local instance = {
        -- propriedades
    }
    setmetatable(instance, %s)
    return instance
end

function %s:method()
    -- implementação
end

return %s
]],
        
        error_handler = [[
local function safe_call(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("Erro: " .. tostring(result))
        return nil
    end
    return result
end
]],
        
        config_loader = [[
local function load_config(filename)
    local file = io.open(filename, "r")
    if not file then
        return nil, "Arquivo não encontrado: " .. filename
    end
    
    local content = file:read("*all")
    file:close()
    
    local config = {}
    local func, err = load("return " .. content, "config", "t", config)
    if not func then
        return nil, "Erro de sintaxe no config: " .. err
    end
    
    return func()
end
]]
    }
end

-- Análise principal de código
function LuaAI:analyze(code)
    local analysis = {
        errors = {},
        warnings = {},
        suggestions = {},
        optimizations = {},
        metrics = {}
    }
    
    -- Análise de sintaxe
    analysis.syntax = self:checkSyntax(code)
    
    -- Análise de padrões
    analysis.patterns = PatternDetector:analyze(code)
    
    -- Análise de performance
    analysis.performance = PerformanceAnalyzer:analyze(code)
    
    -- Geração de sugestões
    analysis.suggestions = SuggestionEngine:generate(code, analysis)
    
    return analysis
end

-- Verificação de sintaxe
function LuaAI:checkSyntax(code)
    local func, err = load(code, "user_code", "t", {})
    if func then
        return { valid = true, message = "Sintaxe válida" }
    else
        return { valid = false, message = err }
    end
end

-- Sistema de sugestões inteligentes
function LuaAI:getSuggestions(code, context)
    local suggestions = {}
    
    -- Detecta variáveis globais não intencionais
    for var in code:gmatch("([%w_]+)%s*=") do
        if not code:find("local%s+" .. var) then
            table.insert(suggestions, {
                type = "warning",
                message = "Considere tornar '" .. var .. "' uma variável local",
                fix = "local " .. var
            })
        end
    end
    
    -- Detecta concatenação de strings em loops
    if code:find("for.*do") and code:find('%.%.') then
        table.insert(suggestions, {
            type = "performance",
            message = "Evite concatenação de strings em loops, use table.concat",
            example = "local parts = {}; table.insert(parts, value); result = table.concat(parts)"
        })
    end
    
    -- Detecta funções muito longas
    local function_count = 0
    for _ in code:gmatch("function") do
        function_count = function_count + 1
    end
    
    local lines = 0
    for _ in code:gmatch("\n") do
        lines = lines + 1
    end
    
    if lines > 50 and function_count < 3 then
        table.insert(suggestions, {
            type = "structure",
            message = "Considere dividir o código em funções menores para melhor organização"
        })
    end
    
    return suggestions
end

-- Otimizações de performance
function LuaAI:optimizeCode(code)
    local optimizations = {}
    
    -- Otimização de acesso a variáveis globais
    local globals = {}
    for global in code:gmatch("([%w_]+)%.") do
        if not globals[global] then
            globals[global] = 0
        end
        globals[global] = globals[global] + 1
    end
    
    for global, count in pairs(globals) do
        if count > 3 then
            table.insert(optimizations, {
                type = "performance",
                message = "Cache a referência global '" .. global .. "'",
                suggestion = "local " .. global .. "_ref = " .. global
            })
        end
    end
    
    return optimizations
end

-- Geração de código a partir de templates
function LuaAI:generateCode(template_name, params)
    local template = self.templates[template_name]
    if not template then
        return nil, "Template não encontrado: " .. template_name
    end
    
    if template_name == "module" or template_name == "class" then
        local name = params.name or "MyModule"
        return string.format(template, name, name, name, name, name, name, name, name)
    end
    
    return template
end

-- Sistema de relatórios
function LuaAI:generateReport(analysis)
    local report = {
        "=== Relatório de Análise LuaAI ===\n"
    }
    
    -- Sintaxe
    table.insert(report, "SINTAXE:")
    if analysis.syntax.valid then
        table.insert(report, "✓ Código sintaticamente correto")
    else
        table.insert(report, "✗ Erro de sintaxe: " .. analysis.syntax.message)
    end
    table.insert(report, "")
    
    -- Sugestões
    if #analysis.suggestions > 0 then
        table.insert(report, "SUGESTÕES:")
        for _, suggestion in ipairs(analysis.suggestions) do
            table.insert(report, "• " .. suggestion.message)
        end
        table.insert(report, "")
    end
    
    -- Métricas
    table.insert(report, "MÉTRICAS:")
    table.insert(report, "• Linhas de código: " .. (analysis.metrics.lines or 0))
    table.insert(report, "• Funções encontradas: " .. (analysis.metrics.functions or 0))
    table.insert(report, "• Complexidade estimada: " .. (analysis.metrics.complexity or "baixa"))
    
    return table.concat(report, "\n")
end

-- Sistema de ajuda
function LuaAI:help()
    return [[
=== LuaAI - Sistema de IA para Programação Lua ===

COMANDOS DISPONÍVEIS:
• analyze(code)           - Analisa código Lua
• getSuggestions(code)    - Obtém sugestões de melhoria  
• optimizeCode(code)      - Sugere otimizações
• generateCode(template)  - Gera código a partir de templates
• generateReport(analysis)- Gera relatório detalhado
• help()                 - Mostra esta ajuda

TEMPLATES DISPONÍVEIS:
• module                 - Cria estrutura de módulo
• class                  - Cria estrutura de classe
• error_handler          - Manipulação segura de erros
• config_loader          - Carregador de configurações

EXEMPLO DE USO:
local ai = LuaAI:new()
local analysis = ai:analyze(seu_codigo)
print(ai:generateReport(analysis))
]]
end

-- Implementação dos módulos auxiliares

-- Analisador de código
CodeAnalyzer = {
    analyze = function(code)
        local metrics = {
            lines = 0,
            functions = 0,
            complexity = 0
        }
        
        for _ in code:gmatch("\n") do
            metrics.lines = metrics.lines + 1
        end
        
        for _ in code:gmatch("function") do
            metrics.functions = metrics.functions + 1
        end
        
        -- Cálculo básico de complexidade
        local complexity_indicators = {
            "if", "for", "while", "repeat", "function"
        }
        
        for _, indicator in ipairs(complexity_indicators) do
            for _ in code:gmatch(indicator) do
                metrics.complexity = metrics.complexity + 1
            end
        end
        
        return metrics
    end
}

-- Detector de padrões
PatternDetector = {
    analyze = function(code)
        local patterns = {
            has_error_handling = code:find("pcall") or code:find("xpcall"),
            uses_local_vars = code:find("local%s+%w+"),
            has_comments = code:find("%-%-"),
            has_documentation = code:find("%-%-%[%["),
            uses_modules = code:find("require") or code:find("module")
        }
        return patterns
    end
}

-- Analisador de performance
PerformanceAnalyzer = {
    analyze = function(code)
        local issues = {}
        
        -- Detecta concatenação de strings
        if code:find('%.%.') then
            table.insert(issues, {
                type = "string_concatenation",
                severity = "medium",
                message = "Concatenação de strings detectada"
            })
        end
        
        -- Detecta loops aninhados
        if code:find("for.-for") then
            table.insert(issues, {
                type = "nested_loops",
                severity = "high", 
                message = "Loops aninhados podem impactar performance"
            })
        end
        
        return issues
    end
}

-- Motor de sugestões
SuggestionEngine = {
    generate = function(code, analysis)
        local suggestions = {}
        
        -- Sugestões baseadas em padrões
        if not analysis.patterns.has_error_handling then
            table.insert(suggestions, {
                type = "best_practice",
                message = "Considere adicionar tratamento de erros com pcall/xpcall"
            })
        end
        
        if not analysis.patterns.has_comments then
            table.insert(suggestions, {
                type = "documentation", 
                message = "Adicione comentários para melhorar a legibilidade"
            })
        end
        
        if not analysis.patterns.uses_local_vars then
            table.insert(suggestions, {
                type = "performance",
                message = "Use variáveis locais sempre que possível"
            })
        end
        
        return suggestions
    end
}

return LuaAI
