-- Jogo da Velha Gráfico com Love2D

local tabuleiro
local jogador_atual
local vencedor
local empate
local botoes

function love.load()
    tabuleiro = { "", "", "", "", "", "", "", "", "" }
    jogador_atual = "X"
    vencedor = nil
    empate = false
    
    -- Configura o tamanho e posição dos 9 botões na tela
    botoes = {}
    local tamanho = 100
    local espacamento = 10
    local offsetX = (love.graphics.getWidth() - (tamanho * 3 + espacamento * 2)) / 2
    local offsetY = (love.graphics.getHeight() - (tamanho * 3 + espacamento * 2)) / 2

    for i = 0, 8 do
        local linha = math.floor(i / 3)
        local coluna = i % 3
        table.insert(botoes, {
            x = offsetX + coluna * (tamanho + espacamento),
            y = offsetY + linha * (tamanho + espacamento),
            w = tamanho,
            h = tamanho,
            id = i + 1
        })
    end
end

function love.draw()
    -- Define a cor de fundo (Azul Escuro)
    love.graphics.clear(0.1, 0.1, 0.15)

    -- Desenha o título e status do jogo
    love.graphics.setColor(1, 1, 1)
    if vencedor then
        love.graphics.print("Jogador " .. vencedor .. " Venceu!", 20, 20, 0, 2, 2)
    elseif empate then
        love.graphics.print("Deu Velha! Empate.", 20, 20, 0, 2, 2)
    else
        love.graphics.print("Turno do Jogador: " .. jogador_atual, 20, 20, 0, 1.5, 1.5)
    end

    -- Desenha os botões do tabuleiro
    for _, b in ipairs(botoes) do
        -- Cor do botão (Cinza claro)
        love.graphics.setColor(0.3, 0.3, 0.35)
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h, 10)

        -- Desenha o X ou O dentro do botão
        local marca = tabuleiro[b.id]
        if marca == "X" then
            love.graphics.setColor(0.2, 0.8, 0.2) -- Verde para X
            love.graphics.print(marca, b.x + 35, b.y + 25, 0, 3, 3)
        elseif marca == "O" then
            love.graphics.setColor(0.8, 0.2, 0.2) -- Vermelho para O
            love.graphics.print(marca, b.x + 35, b.y + 25, 0, 3, 3)
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 and not vencedor and not empate then
        for _, b in ipairs(botoes) do
            -- Verifica se o clique do mouse (ou toque na tela do celular) foi dentro do botão
            if x >= b.x and x <= b.x + b.w and y >= b.y and y <= b.y + b.h then
                if tabuleiro[b.id] == "" then
                    tabuleiro[b.id] = jogador_atual
                    verificar_fim_de_jogo()
                    if not vencedor and not empate then
                        jogador_atual = (jogador_atual == "X") and "O" or "X"
                    end
                end
            end
        end
    end
end

function verificar_fim_de_jogo()
    local combos = {
        {1,2,3}, {4,5,6}, {7,8,9},
        {1,4,7}, {2,5,8}, {3,6,9},
        {1,5,9}, {3,5,7}
    }
    for _, c in ipairs(combos) do
        if tabuleiro[c[1]] ~= "" and tabuleiro[c[1]] == tabuleiro[c[2]] and tabuleiro[c[2]] == tabuleiro[c[3]] then
            vencedor = tabuleiro[c[1]]
            return
        end
    end
    
    -- Verifica empate
    local preenchidos = 0
    for i = 1, 9 do
        if tabuleiro[i] ~= "" then preenchidos = preenchidos + 1 end
    end
    if preenchidos == 9 then empate = true end
end

