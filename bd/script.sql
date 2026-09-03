-- ============================================================
-- PROJETO CEEP+ - SCRIPT DE CRIAÇÃO DO BANCO DE DADOS
-- ETAPA 1: MODELAGEM RELACIONAL
-- ============================================================

-- 1. Tabela de Turmas
CREATE TABLE turmas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_turma VARCHAR(50) NOT NULL, -- Ex: "3ª Série C"
    curso VARCHAR(100) NOT NULL     -- Ex: "Desenvolvimento de Sistemas"
);

-- 2. Tabela de Usuários (Alunos, Coordenação, Direção, Cantina)
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Login institucional
    senha VARCHAR(255) NOT NULL,        -- Hash da senha
    perfil VARCHAR(20) NOT NULL CHECK (perfil IN ('Aluno', 'Coordenacao', 'Direcao', 'Cantina')),
    turma_id INTEGER,
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

-- 3. Tabela de Avisos e Comunicados Oficiais
CREATE TABLE avisos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,
    data_hora_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    autor_id INTEGER NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES usuarios(id)
);

-- 4. Tabela de Bloco de Anotações / Tarefas do Aluno
CREATE TABLE anotacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_entrega DATE,
    aluno_id INTEGER NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id)
);

-- 5. Tabela de Horários e Disciplinas por Turma
CREATE TABLE horarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    dia_semana VARCHAR(15) NOT NULL, -- Ex: "Segunda-feira"
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    disciplina VARCHAR(100) NOT NULL,
    professor VARCHAR(100) NOT NULL,
    turma_id INTEGER NOT NULL,
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

-- 6. Tabela de Produtos da Cantina
CREATE TABLE produtos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    foto_url VARCHAR(255)
);

-- 7. Tabela do Cardápio do Dia
CREATE TABLE cardapio (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_cardapio DATE NOT NULL,
    refeicao_descricao TEXT NOT NULL
);

-- 8. Tabela de Pesquisa de Demanda / Votação de Refeições
CREATE TABLE votos_demanda (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_voto DATE NOT NULL,
    opcao_resposta VARCHAR(20) NOT NULL CHECK (opcao_resposta IN ('Vou comer', 'Não vou comer')),
    aluno_id INTEGER NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id)
);

-- 9. Tabela de Pedidos e Fichas Digitais (QR Code / PIX)
CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status_pagamento VARCHAR(20) DEFAULT 'Pendente' CHECK (status_pagamento IN ('Pendente', 'Pago', 'Cancelado')),
    codigo_qr TEXT NOT NULL,
    status_ficha VARCHAR(20) DEFAULT 'Ativa' CHECK (status_ficha IN ('Ativa', 'Utilizada', 'Expirada')),
    data_hora_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id)
);
