use clinica;

-- Slide 24 

-- 1) nome e CPF dos médicos que também são pacientes do hospital

SELECT m.nome AS medico, m.cpf AS cpf_medico     -- seleciona o nome e o CPF dos médicos
FROM medicos m                                   -- da tabela de médicos (apelidada como "m")
JOIN pacientes p ON m.cpf = p.cpf;               -- faz a junção com pacientes onde o CPF for igual
                                                 -- ou seja: retorna médicos que também são pacientes
 
 -- 2) pares (código, nome) de funcionários e de médicos que residem na mesma cidade
 
 SELECT 
    f.codf AS codigo_funcionarios,       -- código do funcionário
    f.nome AS nome_funcionarios,         -- nome do funcionário
    m.codm AS codigo_medico,             -- código do médico
    m.nome AS nome_medico                -- nome do médico
FROM funcionarios f                      -- tabela de funcionários com alias "f"
JOIN medicos m ON f.cidade = m.cidade;   -- junta com médicos onde a cidade seja igual
                                         -- ou seja: funcionário e médico que moram na mesma cidade

-- 3) Código e nome dos pacientes com consulta marcada para horários após às 14 horas

SELECT 
    p.codp AS codigo_paciente,           -- código do paciente
    p.nome AS nome_paciente,             -- nome do paciente
    c.hora AS consulta                   -- horário da consulta
FROM pacientes p
JOIN consultas c ON c.codp = p.codp      -- junta com a tabela de consultas pelo código do paciente
WHERE c.hora > '14:00:00';               -- filtra as consultas marcadas após as 14 horas

-- 4) Número e andar dos ambulatórios utilizados por médicos ortopedistas

SELECT 
    a.nroa AS numero_ambulatorio,         -- número do ambulatório
    a.andar AS andar_ambulatorio,         -- andar do ambulatório
    m.especialidade AS especialidade      -- especialidade do médico
FROM ambulatorios a
JOIN medicos m ON a.nroa = m.nroa         -- junta médicos com ambulatórios pelo número (nroa)
WHERE m.especialidade = 'ortopedia';      -- filtra apenas médicos ortopedistas

-- 5) nome e CPF dos pacientes que têm consultas marcadas entre os dias 21 e 25 de março de 2024

SELECT 
    p.nome AS nome_do_paciente,              -- nome do paciente
    p.cpf AS cpf_dos_pacientes,              -- CPF do paciente
    c.data AS consulta                       -- data da consulta
FROM pacientes p
JOIN consultas c ON p.codp = c.codp          -- junta consultas com pacientes
WHERE c.data BETWEEN '2024-03-21' AND '2024-03-25';  -- filtra entre os dias 21 e 25 de março de 2024

-- 6) Nome e idade dos médicos que têm consulta com a paciente Ana

SELECT 
    m.nome AS nome_do_medico,           -- nome do médico
    m.idade AS idade_medico,            -- idade do médico
    p.nome AS nome_paciente,            -- nome do paciente
    c.codp AS consulta_codigo           -- código do paciente na consulta
FROM medicos m
JOIN consultas c ON m.codm = c.codm     -- junta médico com consulta
JOIN pacientes p ON p.codp = c.codp     -- junta paciente com consulta
WHERE p.nome = 'Ana Rodrigues';         -- filtra apenas consultas da paciente "Ana Rodrigues"

-- 7) Código e nome dos médicos que atendem no mesmo ambulatório do médico Pedro e que possuem consultas marcadas para dia 14/06/2024
SELECT DISTINCT m2.codm, m2.nome                      -- código e nome dos médicos encontrados
FROM medicos m1
JOIN medicos m2 ON m1.nroa = m2.nroa                  -- compara médicos que atuam no mesmo ambulatório
JOIN consultas c ON c.codm = m2.codm                  -- pega apenas médicos que têm consultas
WHERE m1.nome = 'Pedro'                               -- médico base é o Pedro
  AND c.data = '2024-03-23';                          -- filtra para consultas do dia 23/03/2024


-- 8) Nome, CPF e idade dos pacientes que têm consultas marcadas com ortopedistas para dias anteriores ao dia 16
SELECT p.nome, p.cpf, p.idade                         -- nome, CPF e idade dos pacientes
FROM pacientes p
JOIN consultas c ON c.codp = p.codp                   -- junta pacientes com suas consultas
JOIN medicos m ON m.codm = c.codm                     -- junta consultas com médicos
WHERE m.especialidade = 'ortopedia'                   -- apenas ortopedistas
  AND c.data < '2024-03-24';                          -- datas anteriores a 24/03/2024



-- 9) Nome e salário dos funcionários que moram na mesma cidade do funcionário Carlos e possuem salário superior ao dele
SELECT f2.nome, f2.salario                            -- nome e salário dos funcionários filtrados
FROM funcionarios f1
JOIN funcionarios f2 ON f1.cidade = f2.cidade         -- compara funcionários da mesma cidade
WHERE f1.nome = 'Carlos'                              -- funcionário base é o Carlos
  AND f2.salario > f1.salario;                        -- pega quem ganha mais do que ele
  

-- 10) Dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os seus códigos e nomes
SELECT 
    a.nroa AS numero_ambulatorio,                     -- número do ambulatório
    a.andar,                                          -- andar do ambulatório
    a.capacidade,                                     -- capacidade do ambulatório
    m.codm AS codigo_medico,                          -- código do médico (se houver)
    m.nome AS nome_medico                             -- nome do médico (se houver)
FROM ambulatorios a
LEFT JOIN medicos m ON m.nroa = a.nroa;               -- mostra todos os ambulatórios, mesmo os sem médico


-- 11) CPF e nome de todos os médicos e, para aqueles médicos com consultas marcadas, exibir os CPFs e nomes dos seus pacientes e as datas das consultas
SELECT 
    m.cpf AS cpf_medico,                              -- CPF do médico
    m.nome AS nome_medico,                            -- nome do médico
    p.cpf AS cpf_paciente,                            -- CPF do paciente (se houver)
    p.nome AS nome_paciente,                          -- nome do paciente (se houver)
    c.data AS data_consulta                           -- data da consulta (se houver)
FROM medicos m
LEFT JOIN consultas c ON m.codm = c.codm              -- junta consultas com médicos (traz todos os médicos)
LEFT JOIN pacientes p ON c.codp = p.codp;             -- junta pacientes com consultas (pode ser nulo)
