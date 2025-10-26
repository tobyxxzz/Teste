#!/usr/bin/env lua

--[[
    Interface de Linha de Comando para LuaAI
    
    Permite interação com o sistema de IA através de comandos
--]]

local LuaAI = require('lua_ai')

local CLI = {}
CLI.__index = CLI

function CLI:new()
    local instance = {
        ai = LuaAI:new(),
        commands = {},
        running = true
    }
    setmetatable(instance, CLI)
    instance:setupCommands()
    return instance
end

function CLI:setupCommands()
    self.commands = {
        help = function()
            print([[
=== LuaAI CLI - Comandos Disponíveis ===

analyze <arquivo>     - Analisa um arquivo Lua
check <código>        - Verifica código inline
suggest <arquivo>     - Obtém sugestões para arquivo
optimize <arquivo>    - Sugere otimizações
template <nome>       - Gera template de código
templates             - Lista templates disponíveis
report <arquivo>      - Gera relatório completo
interactive          - Modo interativo
help                 - Mostra esta ajuda
quit                 - Sair do programa

Exemplos:
  luaai analyze meu_codigo.lua
  luaai check "print('hello')"
  luaai template module
]])
        end,

        analyze = function(filename)
            if not filename then
                print("Erro: Especifique um arquivo para analisar")
                return
            end
            
            local file = io.open(filename, "r")
            if not file then
                print("Erro: Arquivo não encontrado - " .. filename)
                return
            end
            
            local code = file:read("*all")
            file:close()
            
            print("Analisando arquivo: " .. filename)
            local analysis = self.ai:analyze(code)
            print(self.ai:generateReport(analysis))
        end,

        check = function(code)
            if not code then
                print("Erro: Forneça código para verificar")
                return
            end
            
            local analysis = self.ai:analyze(code)
            if analysis.syntax.valid then
                print("✓ Código válido")
            else
                print("✗ Erro: " .. analysis.syntax.message)
            end
        end,

        suggest = function(filename)
            if not filename then
                print("Erro: Especifique um arquivo")
                return
            end
            
            local file = io.open(filename, "r")
            if not file then
                print("Erro: Arquivo não encontrado - " .. filename)
                return
            end
            
            local code = file:read("*all")
            file:close()
            
            local suggestions = self.ai:getSuggestions(code)
            if #suggestions > 0 then
                print("Sugestões para " .. filename .. ":")
                for i, sug in ipairs(suggestions) do
                    print(i .. ". " .. sug.message)
                end
            else
                print("Nenhuma sugestão encontrada!")
            end
        end,

        optimize = function(filename)
            if not filename then
                print("Erro: Especifique um arquivo")
                return
            end
            
            local file = io.open(filename, "r")
            if not file then
                print("Erro: Arquivo não encontrado - " .. filename)
                return
            end
            
            local code = file:read("*all")
            file:close()
            
            local optimizations = self.ai:optimizeCode(code)
            if #optimizations > 0 then
                print("Otimizações para " .. filename .. ":")
                for i, opt in ipairs(optimizations) do
                    print(i .. ". " .. opt.message)
                    if opt.suggestion then
                        print("   " .. opt.suggestion)
                    end
                end
            else
                print("Código já está bem otimizado!")
            end
        end,

        template = function(name)
            if not name then
                print("Erro: Especifique um template")
                print("Use 'templates' para ver templates disponíveis")
                return
            end
            
            local code = self.ai:generateCode(name, {name = "Exemplo"})
            if code then
                print("Template '" .. name .. "':")
                print(string.rep("-", 40))
                print(code)
            else
                print("Template não encontrado: " .. name)
            end
        end,

        templates = function()
            print("Templates disponíveis:")
            print("• module - Estrutura de módulo")
            print("• class - Estrutura de classe")
            print("• error_handler - Manipulação de erros")
            print("• config_loader - Carregador de config")
        end,

        report = function(filename)
            if not filename then
                print("Erro: Especifique um arquivo")
                return
            end
            
            local file = io.open(filename, "r")
            if not file then
                print("Erro: Arquivo não encontrado - " .. filename)
                return
            end
            
            local code = file:read("*all")
            file:close()
            
            local analysis = self.ai:analyze(code)
            print(self.ai:generateReport(analysis))
            
            -- Salva o relatório
            local report_file = filename .. ".report.txt"
            local report = io.open(report_file, "w")
            if report then
                report:write(self.ai:generateReport(analysis))
                report:close()
                print("\nRelatório salvo em: " .. report_file)
            end
        end,

        interactive = function()
            print("=== Modo Interativo LuaAI ===")
            print("Digite 'quit' para sair")
            
            while true do
                io.write("luaai> ")
                local input = io.read()
                
                if input == "quit" then
                    break
                end
                
                if input and input:trim() ~= "" then
                    local analysis = self.ai:analyze(input)
                    if analysis.syntax.valid then
                        print("✓ Código válido")
                        local suggestions = self.ai:getSuggestions(input)
                        if #suggestions > 0 then
                            for _, sug in ipairs(suggestions) do
                                print("💡 " .. sug.message)
                            end
                        end
                    else
                        print("✗ " .. analysis.syntax.message)
                    end
                end
            end
        end,

        quit = function()
            print("Saindo do LuaAI...")
            self.running = false
        end
    }
end

function CLI:run(args)
    if not args or #args == 0 then
        print("LuaAI - Sistema de IA para Programação Lua")
        print("Use 'help' para ver comandos disponíveis")
        return
    end
    
    local command = args[1]
    local params = {}
    
    for i = 2, #args do
        table.insert(params, args[i])
    end
    
    if self.commands[command] then
        self.commands[command](table.unpack(params))
    else
        print("Comando não reconhecido: " .. command)
        print("Use 'help' para ver comandos disponíveis")
    end
end

-- Função auxiliar para trim de strings
function string.trim(s)
    return s:match("^%s*(.-)%s*$")
end

-- Execução do CLI
local function main()
    local cli = CLI:new()
    
    -- Processa argumentos da linha de comando
    local args = {...}
    
    if #args > 0 then
        cli:run(args)
    else
        -- Modo interativo simples
        print("=== LuaAI CLI ===")
        print("Digite um comando (help para ajuda, quit para sair):")
        
        while cli.running do
            io.write("> ")
            local input = io.read()
            
            if input then
                local parts = {}
                for part in input:gmatch("%S+") do
                    table.insert(parts, part)
                end
                
                if #parts > 0 then
                    cli:run(parts)
                end
            end
        end
    end
end

-- Executa se for o arquivo principal
if arg and arg[0] and arg[0]:match("cli%.lua$") then
    main()
end

return CLI
