CREATE TABLE turmas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_turma VARCHAR(50) NOT NULL,
    curso VARCHAR(100) NOT NULL   
);

CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, 
    senha VARCHAR(255) NOT NULL,     
    perfil VARCHAR(20) NOT NULL CHECK (perfil IN ('Aluno', 'Coordenacao', 'Direcao', 'Cantina')),
    turma_id INTEGER,
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

CREATE TABLE avisos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT NOT NULL,
    data_hora_publicacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    autor_id INTEGER NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES usuarios(id)
);

CREATE TABLE anotacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_entrega DATE,
    aluno_id INTEGER NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id)
);

CREATE TABLE horarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    dia_semana VARCHAR(15) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    disciplina VARCHAR(100) NOT NULL,
    professor VARCHAR(100) NOT NULL,
    turma_id INTEGER NOT NULL,
    FOREIGN KEY (turma_id) REFERENCES turmas(id)
);

CREATE TABLE produtos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    foto_url VARCHAR(255)
);

CREATE TABLE cardapio (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_cardapio DATE NOT NULL,
    refeicao_descricao TEXT NOT NULL
);

CREATE TABLE votos_demanda (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_voto DATE NOT NULL,
    opcao_resposta VARCHAR(20) NOT NULL CHECK (opcao_resposta IN ('Vou comer', 'Não vou comer')),
    aluno_id INTEGER NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES usuarios(id)
);

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
