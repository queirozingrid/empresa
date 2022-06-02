CREATE DATABASE empresa;

USE empresa;

-- CRIAÇÃO DE TABELAS A SEGUIR

CREATE TABLE funcionario(
	Pnome VARCHAR(20) NOT NULL,
  	MInicial CHAR(1),
  	UNome VARCHAR(20) NOT NULL,
  	cpf VARCHAR(11) NOT NULL PRIMARY KEY,
  	data_nasc DATE NOT NULL CHECK(data_nasc < getdate()),
  	endereco VARCHAR(80),
  	sexo CHAR(1) NOT NULL,
  	salario DECIMAL(10, 2) NOT NULL CHECK(salario > 0),
  	cpf_supervisor VARCHAR(11),
  	dnr INT  
);

CREATE TABLE departamento(
	Dnome VARCHAR(20) NOT NULL,
  	Dnumero INT NOT NULL PRIMARY KEY,
  	cpf_gerente VARCHAR(11) NOT NULL,
  	data_inicio_gerente DATE NOT NULL CHECK(data_inicio_gerente < getdate())
);

-- ADICIONANDO RELACIONAMENTO ENTRE dnr (funcionario) e Dnumero (departamento)
ALTER TABLE funcionario
ADD FOREIGN KEY (dnr) REFERENCES departamento(Dnumero);

-- CRIAÇÃO DA TABELA LOCALIZACOES_DEP
CREATE TABLE localizacoes_dep(
	Dnumero INT,
  	Dlocal VARCHAR(50) NOT NULL
)

-- ADICIONANDO RELACIONAMENTO ENTRE Dnumero(localizacoes_dep) e Dnumero(departamento)
ALTER TABLE localizacoes_dep
ADD FOREIGN KEY (Dnumero) REFERENCES departamento(Dnumero);

-- CRIAÇÃO DA TABELA PROJETO
CREATE TABLE projeto(
	Projnome VARCHAR(20) NOT NULL,
  	Projnumero INT NOT NULL PRIMARY KEY,
  	Projlocal VARCHAR(50) NOT NULL,
  	Dnum INT
)

-- ADICIONANDO RELACIONAMENTO ENTRE Dnum(projeto) e Dnumero(departamento)
ALTER TABLE projeto
ADD FOREIGN KEY (Dnum) REFERENCES departamento(Dnumero);

-- CRIAÇÃO DA TABELA trabalha_em (já com os relacionamentos - me desafiei e deu certo ó)
CREATE TABLE trabalha_em(
  	Fcpf VARCHAR(11),
  	Pnr INT,
  	horas DECIMAL(10, 2),
	CONSTRAINT Fcpf FOREIGN KEY (Fcpf) REFERENCES funcionario(cpf),
  	CONSTRAINT Pnr FOREIGN KEY (Pnr) REFERENCES projeto(Projnumero)
);
-- CRIAÇÃO DA TABELA dependente (já com os relacionamentos porque agora eu aprendi)
-- Não sei por quê, essa tabela não me deixou criar igual a tabela de cima,
-- No constraint, tive que usar "fk_Fcpf" (talvez estivesse dando conflito)
CREATE TABLE dependente(
	Fcpf VARCHAR(11),
  	Nome_dependente VARCHAR(20) NOT NULL,
  	sexo CHAR(1) NOT NULL,
  	Datanasc DATE NOT NULL CHECK(Datanasc < getdate()),
  	parentesco VARCHAR(20),
    CONSTRAINT fk_Fcpf FOREIGN KEY (Fcpf) REFERENCES funcionario(cpf)
);

-- INSERÇÃO DE VALORES NA TABELA departamento (para não dar conflito por causa do número do departamento,
-- que é chave estrangeira em funcionario)
INSERT INTO departamento(
	Dnome, Dnumero, cpf_gerente, data_inicio_gerente
) VALUES
	('Pesquisa', 5, '33344555587', '1988-05-22'),
    ('Administração', 4, '98765432168', '1995-01-01'),
    ('Matriz', 1, '88866555576', '1981-06-19');

-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM departamento;

-- INSERÇÃO DE VALORES NA TABELA funcionario
INSERT INTO funcionario(
	Pnome, MInicial, UNome, cpf, data_nasc, endereco, sexo, salario, cpf_supervisor, dnr
) VALUES
	(
      'João', 'B', 'Silva', '12345678966', '1965-01-09',
      'Rua das Flores, 751, São Paulo, SP', 'M',
      30000, '33344555587', 5
    ),
    (
      'Fernando', 'T', 'Wong', '33344555587', '1955-08-12',
      'Rua da Lapa, 34, São Paulo, SP', 'M',
      40000, '88866555576', 5
    ),
    (
      'Alice', 'J', 'Zelaya', '99988777767', '1968-01-19',
      'Rua Souza Lima, 35, Curitiba, PR', 'F',
      25000, '98765432168', 4
    ),
    (
      'Jennifer', 'S', 'Souza', '98765432168', '1941-06-20',
      'Av. Arthur de Lima, 54, Santo André, SP', 'F',
      43000, '88866555576', 4
    ),
    (
      'Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15',
      'Rua Rebouças, 65, Piracicaba, SP', 'M',
      38000, '33344555587', 5
    ),
    (
      'Joice', 'A', 'Leite', '45345345376', '1972-07-31',
      'Av. Lucas Obes, 74, São Paulo, SP', 'F',
      25000, '33344555587', 5	
    ),
    (
      'André', 'V', 'Pereira', '98798798733', '1969-03-29',
      'Rua Timbira, 35, São Paulo, SP', 'M',
      25000, '98765432168', 4
    ),
    (
      'Jorge', 'E', 'Brito', '88866555576', '1937-11-10',
      'Rua do Horto, 35, São Paulo, SP', 'M',
      55000, NULL, 1
    );

-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM funcionario;

-- INSERÇÃO DE VALORES NA TABELA localizacoes_dep
INSERT INTO localizacoes_dep(
	Dnumero, Dlocal
) VALUES
	(1, 'São Paulo'),
    (4, 'Mauá'),
    (5, 'Santo André'),
    (5, 'Itu'),
    (5, 'São Paulo');
-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM localizacoes_dep;

-- INSERÇÃO DE VALORES NA TABELA projeto
INSERT INTO projeto(
	Projnome, Projnumero, Projlocal, Dnum
) VALUES
	('ProdutoX', 1, 'Santo André', 5),
    ('ProdutoY', 2, 'Itu', 5),
    ('ProdutoZ', 3, 'São Paulo', 5),
    ('Informatização', 10, 'Mauá', 4),
    ('Reorganização', 20, 'São Paulo', 1),
    ('Novosbenefícios', 30, 'Mauá', 4);
    
-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM projeto;

-- INSERÇÃO DE VALORES NA TABELA trabalha_em
INSERT INTO trabalha_em(
	Fcpf, Pnr, horas
) VALUES
	('12345678966', 1, 32.5),
    ('12345678966', 2, 7.5),
    ('66688444476', 3, 40),
    ('45345345376', 1, 20),
    ('45345345376', 2, 20),
    ('33344555587', 2, 10),
    ('33344555587', 3, 10),
    ('33344555587', 10, 10),
    ('33344555587', 20, 10),
    ('99988777767', 30, 30),
    ('99988777767', 10, 10),
    ('98798798733', 10, 35),
    ('98798798733', 30, 5),
    ('98765432168', 30, 20),
    ('98765432168', 20, 15),
    ('88866555576', 20, NULL);
    
-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM trabalha_em
    
-- INSERÇÃO DE VALORES NA TABELA dependente
INSERT INTO dependente(
  Fcpf, Nome_dependente, sexo, Datanasc, parentesco
) VALUES 
	('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
    ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
    ('33344555587', 'Janaína', 'F', '1958-03-03', 'Esposa'),
    ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
    ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
    ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
    ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
    
-- FIZ APENAS PARA VERIFICAR A INSERÇÃO
SELECT * FROM dependente

----------------- CONSULTAS A SEGUIR -------------------
-- 1. data de nascimento e o endereço dos funcionários cujo
-- nome seja ‘João B. Silva’.

SELECT data_nasc, endereco FROM funcionario
WHERE funcionario.Pnome = 'João' AND
	  funcionario.MInicial = 'B' AND
      funcionario.UNome = 'Silva';
      
-- 2. nome e endereço de todos os funcionários que trabalham
-- para o departamento ‘Pesquisa’

-- Fiz de duas formas: puxando diretamente pelo dnr (que é 5) e também fiz utilizando INNER JOIN
-- Diretamente pelo nome:
SELECT Pnome, endereco FROM funcionario
WHERE dnr = 5

-- Utilizando INNER JOIN:
SELECT Pnome, endereco FROM funcionario f
INNER JOIN departamento d
ON f.dnr = d.Dnumero AND d.Dnome = 'Pesquisa'


-- 3. Para cada projeto localizado em ‘Mauá’, liste o número do projeto, o
-- número do departamento que o controla e o sobrenome, endereço e
-- data de nascimento do gerente do departamento.

SELECT p.Projnumero,
	   d.Dnumero,
       f.Unome, f.endereco, f.data_nasc

FROM projeto p INNER JOIN departamento d
ON p.Dnum = d.Dnumero
INNER JOIN funcionario f
ON d.cpf_gerente = f.cpf
WHERE p.Projlocal = 'Mauá'

-- 4. Para cada funcionário, recupere o primeiro e o último nome do
-- funcionário e o primeiro e o último nome de seu supervisor imediato.
SELECT f1.Pnome, f1.UNome,
	   f2.Pnome as 'Nome Supervisor', f2.UNome as 'Sobrenome Supervisor'
       
FROM funcionario f1
INNER JOIN funcionario f2
ON f1.cpf_supervisor = f2.cpf;

-- 5. Consulte todos os Cpfs de FUNCIONARIO.
SELECT cpf FROM funcionario;

-- 6. Consulte Cpf e Dnome (nome de departamento) de cada funcionário.
SELECT f.cpf, d.Dnome FROM funcionario f
INNER JOIN departamento d
ON d.Dnumero = f.dnr;

-- 7. Recupere todos os valores de salário distintos de funcionários.
SELECT DISTINCT salario FROM funcionario;

-- 8. Exiba os números dos projetos que possuem funcionário ou gerente
-- com o último nome ‘Silva’

SELECT Projnumero FROM projeto p
INNER JOIN trabalha_em te
ON p.Projnumero = te.Pnr
INNER JOIN funcionario f
ON te.Fcpf = f.cpf
AND f.UNome = 'Silva';

-- 9. Recuperar todos os funcionários cujo endereço esteja em ‘São Paulo, SP’.

SELECT * FROM funcionario
WHERE endereco LIKE '%São Paulo, SP%';

--10. Encontrar todos os funcionários que nasceram durante a década de 1950.
SELECT * FROM funcionario
WHERE data_nasc BETWEEN '1950' AND '1960';

-- 11. Mostrar nome completo do funcionário e salário acrescido de 10% dos
-- funcionários que trabalham no projeto ‘ProdutoX’.

SELECT f.Pnome, f.MInicial, f.UNome, salario*1.1 as 'Salário Acrescido' FROM funcionario f
INNER JOIN trabalha_em te
ON f.cpf = te.Fcpf
INNER JOIN projeto p
ON p.Projnumero = te.Pnr
AND p.Projnome = 'ProdutoX';


-- 12. Recuperar nome completo de todos os funcionários no departamento
-- 5, cujo salário esteja entre R$ 30.000,00 e R$ 40.000,00

SELECT f.Pnome, f.MInicial, f.UNome FROM funcionario f
WHERE f.dnr = 5 AND f.salario BETWEEN 30000 AND 40000;

-- 13. Recuperar nome do departamento, nome completo do funcionário e
-- nome do projeto onde ele trabalha, ordenado por departamento, e,
-- dentro de cada departamento, ordenado alfabeticamente pelo
-- sobrenome, depois pelo nome.

SELECT d.Dnome,
	   f.Pnome,
       f.MInicial,
       f.UNome,
       p.Projnome
FROM departamento d
INNER JOIN funcionario f
ON d.Dnumero = f.dnr
INNER JOIN projeto p
ON p.Dnum = d.Dnumero

ORDER BY f.dnr, f.UNome ASC, f.Pnome;

-- 14. Recupere os nomes de todos os funcionários no departamento 5 que
-- trabalham mais de 10 horas por semana no projeto ‘ProdutoX’.

SELECT f.Pnome FROM funcionario f
INNER JOIN trabalha_em te
ON f.cpf = te.Fcpf
AND te.horas > 10
INNER JOIN projeto p
ON te.Pnr = p.Projnumero
AND p.Projnome = 'ProdutoX'
WHERE f.dnr = 5;

-- 15. Liste os nomes de todos os funcionários que possuem um dependente
-- com o mesmo primeiro nome que seu próprio.
SELECT f.Pnome FROM funcionario f
INNER JOIN dependente d
ON f.Pnome = d.Nome_dependente;


-- 16. Ache os nomes de todos os funcionários que são supervisionados
-- diretamente por ‘Fernando Wong’

SELECT Pnome FROM funcionario f
WHERE
	(	SELECT f.cpf FROM funcionario f
     	WHERE f.Pnome = 'Fernando'
     	AND f.UNome = 'Wong'	) = f.cpf_supervisor;
        
-- 17. Recuperar os nomes de todos os funcionários que não possuem supervisores.
SELECT f.Pnome FROM funcionario f
WHERE f.cpf_supervisor IS NULL OR f.cpf_supervisor = '';

-- 18.  Selecionar CPFs de todos os funcionários que trabalham na mesma
-- combinação de projeto e horas que o funcionário de CPF
-- 12345678966 trabalha.


SELECT DISTINCT f.cpf FROM funcionario f
INNER JOIN trabalha_em te
ON f.cpf = te.Fcpf
AND te.Pnr =
	ANY (SELECT p.Projnumero FROM projeto p
         INNER JOIN trabalha_em te
         ON p.Projnumero = te.Pnr
         AND te.Fcpf = '12345678966');

-- 19. Exibir os nomes dos funcionários cujo salário é maior do que o salário
-- de todos os funcionários do departamento de número 5.

SELECT f.Pnome FROM funcionario f
WHERE f.salario >
	ALL ( SELECT f.salario FROM funcionario f
			WHERE f.dnr = 5);

-- 20. Obter o nome de cada funcionário que tem um dependente com o
-- mesmo sexo do funcionário.

SELECT f.Pnome, d.Nome_dependente FROM funcionario f
INNER JOIN dependente d
ON f.cpf = d.Fcpf
AND f.sexo = d.sexo;

-- 21. Listar os nomes dos gerentes que possuem pelo menos um dependente
SELECT DISTINCT f.Pnome, FROM funcionario f
INNER JOIN departamento d
ON f.cpf = d.cpf_gerente
INNER JOIN dependente dpdt
ON d.cpf_gerente = dpdt.Fcpf;

-- 22. Listar os CPFs de todos os funcionários que trabalham nos projetos
-- de números 1, 2 ou 3

SELECT DISTINCT f.cpf FROM funcionario f
INNER JOIN trabalha_em te
ON f.cpf = te.Fcpf
INNER JOIN projeto p
ON te.Pnr = p.Projnumero
AND (p.Projnumero = 1 OR p.Projnumero = 2 OR p.Projnumero = 3);

-- 23. Exibir a soma dos salários de todos os funcionários, o salário máximo,
-- o salário mínimo e a média dos salários.

SELECT SUM(f.salario) AS 'SOMA DE TODOS OS SALÁRIOS',
	   MAX(f.salario) AS 'SALÁRIO MÁXIMO',
       MIN(f.salario) AS 'SALÁRIO MÍNIMO',
       AVG(f.salario) AS 'MÉDIA DOS SALÁRIOS' FROM funcionario f;

-- 24. Exibir a soma dos salários de todos os funcionários de cada
-- departamento, bem como o salário máximo, o salário mínimo e a
-- média dos salários de cada um desses departamentos.

SELECT f.dnr AS 'DEPARTAMENTO',
	   SUM(f.salario) AS 'SOMA DOS SALÁRIOS',
	   MAX(f.salario) AS 'SALÁRIO MÁXIMO',
       MIN(f.salario) AS 'SALÁRIO MÍNIMO',
       AVG(f.salario) AS 'MÉDIA DOS SALÁRIOS'
       FROM funcionario f
INNER JOIN departamento d
ON f.dnr = d.Dnumero GROUP BY f.dnr;

-- 25. Recuperar o número total de funcionários da empresa
SELECT COUNT(*) AS 'TOTAL DE FUNCIONÁRIOS' FROM funcionario;

-- 26. Recuperar o número de funcionários de cada departamento.
SELECT f.dnr AS 'NÚMERO DEPARTAMENTO',
	   COUNT(*) AS 'Quantidade de funcionários'
       FROM funcionario f
INNER JOIN departamento d
ON f.dnr = d.Dnumero GROUP BY f.dnr;

-- 27. Obter o número de valores distintos de salário.
SELECT COUNT(DISTINCT salario) AS 'VALORES DISTINTOS' FROM funcionario;

-- 28. Exibir os nomes de todos os funcionários que possuem dois ou mais dependentes.
SELECT f.Pnome FROM funcionario f
INNER JOIN dependente d
ON f.cpf = d.Fcpf
GROUP BY f.Pnome HAVING COUNT(f.Pnome) > 2;

-- 29. Exibir o número do departamento, o número de funcionários no
-- departamento e o salário médio do departamento, para cada departamento da empresa.

SELECT d.Dnumero AS 'NÚMERO DEPARTAMENTO',
	   COUNT(f.cpf) AS 'NÚMERO DE FUNCIONÁRIOS',
       AVG(f.salario) AS 'MÉDIA DE SALÁRIO'
       FROM departamento d
INNER JOIN funcionario f
ON f.dnr = d.Dnumero
GROUP BY d.Dnumero;

-- 30. Listar o número do projeto, o nome do projeto e o número de
-- funcionários que trabalham nesse projeto, para cada projeto

SELECT DISTINCT te.Pnr AS 'NÚMERO PROJETO',
		p.Projnome AS 'NOME PROJETO',
        COUNT(te.Fcpf) AS 'NÚMERO DE FUNCIONARIOS'
	    FROM trabalha_em te
INNER JOIN projeto p
ON p.Projnumero = te.Pnr
INNER JOIN funcionario f
ON f.cpf = te.Fcpf
GROUP BY te.Pnr, p.Projnome;






