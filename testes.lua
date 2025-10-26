#!/usr/bin/env lua

--[[
    Testes para o sistema LuaAI
    
    Este arquivo contém testes automatizados para validar
    o funcionamento correto do sistema de IA
--]]

local LuaAI = require('lua_ai')

local Testes = {}
Testes.__index = Testes

function Testes:new()
    local instance = {
        ai = LuaAI:new(),
        testes_passou = 0,
        testes_falhou = 0,
        resultados = {}
    }
    setmetatable(instance, Testes)
    return instance
end

-- Framework básico de testes
function Testes:assert(condicao, mensagem)
    if condicao then
        self.testes_passou = self.testes_passou + 1
        table.insert(self.resultados, {tipo = "PASSOU", mensagem = mensagem})
        print("✓ " .. mensagem)
    else
        self.testes_falhou = self.testes_falhou + 1
        table.insert(self.resultados, {tipo = "FALHOU", mensagem = mensagem})
        print("✗ " .. mensagem)
    end
end

-- Testa criação da instância
function Testes:teste_criar_instancia()
    print("\n=== Testando Criação da Instância ===")
    
    local ai = LuaAI:new()
    self:assert(ai ~= nil, "Instância da AI foi criada")
    self:assert(ai.version == "1.0.0", "Versão correta carregada")
    self:assert(type(ai.patterns) == "table", "Padrões carregados")
    self:assert(type(ai.templates) == "table", "Templates carregados")
end

-- Testa análise de sintaxe
function Testes:teste_analise_sintaxe()
    print("\n=== Testando Análise de Sintaxe ===")
    
    -- Código válido
    local codigo_valido = "local x = 5; print(x)"
    local resultado = self.ai:checkSyntax(codigo_valido)
    self:assert(resultado.valid == true, "Detecta código válido corretamente")
    
    -- Código inválido
    local codigo_invalido = "local x = ; print(x)"
    local resultado_invalido = self.ai:checkSyntax(codigo_invalido)
    self:assert(resultado_invalido.valid == false, "Detecta código inválido corretamente")
end

-- Testa detecção de padrões
function Testes:teste_deteccao_padroes()
    print("\n=== Testando Detecção de Padrões ===")
    
    -- Código com variáveis locais
    local codigo_local = "local x = 5; local y = 10"
    local analysis = self.ai:analyze(codigo_local)
    self:assert(analysis.patterns.uses_local_vars == true, "Detecta uso de variáveis locais")
    
    -- Código com comentários
    local codigo_comentado = "-- Este é um comentário\nlocal x = 5"
    local analysis_comentado = self.ai:analyze(codigo_comentado)
    self:assert(analysis_comentado.patterns.has_comments == true, "Detecta comentários")
    
    -- Código com tratamento de erros
    local codigo_pcall = "local ok, result = pcall(function() return 1/0 end)"
    local analysis_pcall = self.ai:analyze(codigo_pcall)
    self:assert(analysis_pcall.patterns.has_error_handling == true, "Detecta tratamento de erros")
end

-- Testa geração de sugestões
function Testes:teste_sugestoes()
    print("\n=== Testando Geração de Sugestões ===")
    
    -- Código com variáveis globais
    local codigo_global = "x = 5; y = 10; print(x + y)"
    local sugestoes = self.ai:getSuggestions(codigo_global)
    self:assert(#sugestoes > 0, "Gera sugestões para variáveis globais")
    
    -- Verifica se sugere usar local
    local tem_sugestao_local = false
    for _, sugestao in ipairs(sugestoes) do
        if sugestao.message:find("local") then
            tem_sugestao_local = true
            break
        end
    end
    self:assert(tem_sugestao_local, "Sugere uso de variáveis locais")
end

-- Testa análise de performance
function Testes:teste_analise_performance()
    print("\n=== Testando Análise de Performance ===")
    
    -- Código com concatenação em loop
    local codigo_concat = [[
        local result = ""
        for i = 1, 100 do
            result = result .. "texto" .. i
        end
    ]]
    
    local sugestoes = self.ai:getSuggestions(codigo_concat)
    local tem_sugestao_performance = false
    for _, sugestao in ipairs(sugestoes) do
        if sugestao.type == "performance" then
            tem_sugestao_performance = true
            break
        end
    end
    self:assert(tem_sugestao_performance, "Detecta problemas de performance")
end

-- Testa geração de templates
function Testes:teste_templates()
    print("\n=== Testando Geração de Templates ===")
    
    local template_modulo = self.ai:generateCode("module", {name = "TestModule"})
    self:assert(template_modulo ~= nil, "Gera template de módulo")
    self:assert(template_modulo:find("TestModule"), "Template contém nome correto")
    
    local template_classe = self.ai:generateCode("class", {name = "TestClass"})
    self:assert(template_classe ~= nil, "Gera template de classe")
    
    local template_error = self.ai:generateCode("error_handler")
    self:assert(template_error ~= nil, "Gera template de manipulador de erros")
    self:assert(template_error:find("pcall"), "Template de erro contém pcall")
end

-- Testa geração de relatórios
function Testes:teste_relatorios()
    print("\n=== Testando Geração de Relatórios ===")
    
    local codigo_teste = "local x = 5; print(x)"
    local analysis = self.ai:analyze(codigo_teste)
    local relatorio = self.ai:generateReport(analysis)
    
    self:assert(type(relatorio) == "string", "Relatório é gerado como string")
    self:assert(relatorio:find("SINTAXE"), "Relatório contém seção de sintaxe")
    self:assert(relatorio:find("MÉTRICAS"), "Relatório contém métricas")
end

-- Testa sistema de ajuda
function Testes:teste_ajuda()
    print("\n=== Testando Sistema de Ajuda ===")
    
    local ajuda = self.ai:help()
    self:assert(type(ajuda) == "string", "Sistema de ajuda retorna string")
    self:assert(ajuda:find("COMANDOS"), "Ajuda contém lista de comandos")
    self:assert(ajuda:find("analyze"), "Ajuda menciona comando analyze")
end

-- Testa análise completa com código complexo
function Testes:teste_analise_complexa()
    print("\n=== Testando Análise Complexa ===")
    
    local codigo_complexo = [[
        -- Função complexa para teste
        function processar_dados(dados)
            local resultado = {}
            for i = 1, #dados do
                if dados[i].ativo then
                    local processado = {}
                    processado.id = dados[i].id
                    processado.valor = dados[i].valor * 2
                    
                    if processado.valor > 100 then
                        processado.categoria = "alto"
                    else
                        processado.categoria = "baixo"
                    end
                    
                    table.insert(resultado, processado)
                end
            end
            return resultado
        end
    ]]
    
    local analysis = self.ai:analyze(codigo_complexo)
    self:assert(analysis.syntax.valid == true, "Análise complexa: sintaxe válida")
    self:assert(analysis.patterns.uses_local_vars == true, "Análise complexa: detecta locais")
    self:assert(analysis.patterns.has_comments == true, "Análise complexa: detecta comentários")
end

-- Executa todos os testes
function Testes:executar_todos()
    print("=== Iniciando Testes do LuaAI ===")
    
    self:teste_criar_instancia()
    self:teste_analise_sintaxe()
    self:teste_deteccao_padroes()
    self:teste_sugestoes()
    self:teste_analise_performance()
    self:teste_templates()
    self:teste_relatorios()
    self:teste_ajuda()
    self:teste_analise_complexa()
    
    self:exibir_resultados()
end

-- Exibe resultados finais
function Testes:exibir_resultados()
    print("\n" .. string.rep("=", 50))
    print("RESULTADOS DOS TESTES")
    print(string.rep("=", 50))
    
    local total = self.testes_passou + self.testes_falhou
    local percentual = math.floor((self.testes_passou / total) * 100)
    
    print("Total de testes: " .. total)
    print("Passou: " .. self.testes_passou)
    print("Falhou: " .. self.testes_falhou)
    print("Taxa de sucesso: " .. percentual .. "%")
    
    if self.testes_falhou == 0 then
        print("\n🎉 Todos os testes passaram! O LuaAI está funcionando corretamente.")
    else
        print("\n⚠️  Alguns testes falharam. Verifique a implementação.")
        
        print("\nTestes que falharam:")
        for _, resultado in ipairs(self.resultados) do
            if resultado.tipo == "FALHOU" then
                print("• " .. resultado.mensagem)
            end
        end
    end
    
    print(string.rep("=", 50))
end

-- Executa os testes se for o arquivo principal
if arg and arg[0] and arg[0]:match("testes%.lua$") then
    local testes = Testes:new()
    testes:executar_todos()
end

return Testes
