# Glossário e Dicionário de Dados - futebol_OLAP_db

## Glossário de Termos

| Termo | Descrição |
|-------|-----------|
| OLAP | OnLine Analytical Processing - Tipo de processamento de dados otimizado para consultas analíticas complexas |
| Dimensão | Tabela contendo atributos descritivos que permitem filtrar e categorizar os dados das tabelas fato |
| Fato | Tabela contendo medidas numéricas e chaves estrangeiras para as dimensões associadas |
| Agregação | Consolidação de dados por agrupamento com operações de soma, média, contagem, etc. |
| Ponte | Tabela de junção que relaciona duas outras tabelas (ex: PontePartidaTime relaciona times e partidas) |
| Artilharia | Estatística que contabiliza os gols marcados por um jogador em uma competição |
| Classificação | Tabela que mostra a posição dos times em um campeonato baseada em pontos e outros critérios |
| Rodada | Conjunto de jogos que acontecem em um mesmo período do campeonato |
| Gol Contra | Gol marcado por um jogador em sua própria meta (a favor do adversário) |

## Dicionário de Dados

### Tabelas de Dimensão

#### DimData

Dimensão que armazena informações de tempo.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| DataID | INT | Identificador único da data | Chave primária, Auto-incremento |
| Data | DATE | Data completa | Permite nulo |
| Ano | INT | Ano da data | Permite nulo |
| Mes | INT | Mês da data | Permite nulo |
| Dia | INT | Dia da data | Permite nulo |
| DiaSemana | CHAR(3) | Dia da semana abreviado | Permite nulo, Valores: 'DOM','SEG','TER','QUA','QUI','SEX','SAB' |

#### DimEstadio

Dimensão que armazena informações sobre os estádios.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| EstadioID | INT | Identificador único do estádio | Chave primária, Auto-incremento |
| Nome | NVARCHAR(45) | Nome do estádio | Permite nulo |
| Capacidade | INT | Capacidade máxima de público | Permite nulo |
| Cidade | NVARCHAR(45) | Cidade onde está localizado | Permite nulo |
| Latitude | FLOAT | Coordenada geográfica - latitude | Permite nulo |
| Longitude | FLOAT | Coordenada geográfica - longitude | Permite nulo |

#### DimClube

Dimensão que armazena informações sobre os times/clubes.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| TimeID | INT | Identificador único do time | Chave primária, Auto-incremento |
| Nome | NVARCHAR(45) | Nome do clube | Não permite nulo |
| Titulos | INT | Número de títulos na competição | Não permite nulo |
| Participacoes | INT | Número de participações na competição | Não permite nulo |
| Fundacao | DATE | Data de fundação do clube | Não permite nulo |
| Sede | NVARCHAR(30) | Cidade sede do clube | Não permite nulo |
| Escudo | NVARCHAR(1000) | URL ou caminho para a imagem do escudo | Permite nulo |

#### DimJogador

Dimensão que armazena informações sobre os jogadores.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| JogadorID | INT | Identificador único do jogador | Chave primária, Auto-incremento |
| Nome | NVARCHAR(45) | Nome do jogador | Permite nulo |
| Posicao | NVARCHAR(45) | Posição em que joga | Permite nulo |
| Nascimento | DATE | Data de nascimento | Permite nulo |
| TimeID | INT | ID do time ao qual pertence | Chave estrangeira (DimClube), Permite nulo |

#### DimJuiz

Dimensão que armazena informações sobre os árbitros.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| JuizID | INT | Identificador único do árbitro | Chave primária, Auto-incremento |
| Nome | NVARCHAR(45) | Nome do árbitro | Permite nulo |
| Nivel | NVARCHAR(45) | Nível de qualificação do árbitro | Permite nulo, Valores: 'ESTADUAL','NACIONAL','INTERNACIONAL' |

### Tabelas de Agregação

#### AggArtilharia

Tabela de agregação com estatísticas de gols por jogador.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| JogadorID | INT | Identificador do jogador | Chave primária, Chave estrangeira (DimJogador) |
| Gols | INT | Total de gols marcados pelo jogador | Permite nulo |

### Tabelas de Fato

#### FatoPartida

Fato que armazena informações sobre as partidas realizadas.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| PartidaID | INT | Identificador único da partida | Chave primária, Auto-incremento |
| DataID | INT | ID da data da partida | Chave estrangeira (DimData), Não permite nulo |
| EstadioID | INT | ID do estádio onde ocorreu | Chave estrangeira (DimEstadio), Não permite nulo |
| JuizID | INT | ID do árbitro principal | Chave estrangeira (DimJuiz), Não permite nulo |
| Publico | INT | Número de espectadores presentes | Permite nulo |
| Renda | DECIMAL(10,2) | Valor arrecadado com ingressos | Permite nulo |
| Resultado | NVARCHAR(10) | Placar final da partida | Permite nulo |

#### PontePartidaTime

Tabela ponte que relaciona times e partidas, contendo estatísticas por time em cada partida.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| TimeID | INT | ID do time | Parte da chave primária composta, Chave estrangeira (DimClube) |
| PartidaID | INT | ID da partida | Parte da chave primária composta, Chave estrangeira (FatoPartida) |
| PosseDeBola | INT | Percentual de posse de bola do time | Permite nulo |
| Escanteios | INT | Número de escanteios do time | Permite nulo |
| ChutesAGol | INT | Número de finalizações no gol | Permite nulo |
| Impedimentos | INT | Número de impedimentos | Permite nulo |

#### FatoCartao

Fato que armazena informações sobre cartões aplicados nas partidas.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| CartaoID | INT | Identificador único do cartão | Chave primária, Auto-incremento |
| PartidaID | INT | ID da partida | Chave estrangeira (FatoPartida), Não permite nulo |
| JogadorID | INT | ID do jogador que recebeu | Chave estrangeira (DimJogador), Não permite nulo |
| TimeID | INT | ID do time do jogador | Chave estrangeira (DimClube), Não permite nulo |
| Minuto | INT | Minuto em que o cartão foi aplicado | Permite nulo |
| Tempo | INT | Tempo do jogo (1º ou 2º) | Permite nulo, Valores: 1, 2 |
| Cor | CHAR(1) | Cor do cartão | Permite nulo, Valores: 'A' (amarelo), 'V' (vermelho) |

#### FatoClassificacao

Fato que armazena a classificação dos times por rodada.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| RodadaID | INT | Identificador da rodada | Parte da chave primária composta |
| TimeID | INT | ID do time | Parte da chave primária composta, Chave estrangeira (DimClube) |
| Pontos | INT | Total de pontos acumulados | Permite nulo |
| Jogos | INT | Total de jogos disputados | Permite nulo |
| Vitorias | INT | Total de vitórias | Permite nulo |
| Empates | INT | Total de empates | Permite nulo |
| Derrotas | INT | Total de derrotas | Permite nulo |
| GolsPro | INT | Total de gols marcados | Permite nulo |
| GolsContra | INT | Total de gols sofridos | Permite nulo |
| Saldo | INT (calculado) | Diferença entre gols pró e contra | Coluna calculada (GolsPro - GolsContra) |

#### FatoGol

Fato que armazena informações sobre os gols marcados nas partidas.

| Coluna | Tipo de Dado | Descrição | Restrições |
|--------|-------------|-----------|------------|
| GolID | INT | Identificador único do gol | Chave primária, Auto-incremento |
| PartidaID | INT | ID da partida | Chave estrangeira (FatoPartida), Não permite nulo |
| JogadorID | INT | ID do jogador que marcou | Chave estrangeira (DimJogador), Não permite nulo |
| TimeID | INT | ID do time do jogador | Chave estrangeira (DimClube), Permite nulo |
| Minuto | INT | Minuto em que o gol foi marcado | Permite nulo |
| Tempo | INT | Tempo do jogo (1º ou 2º) | Permite nulo |
| GolContra | INT | Indica se foi gol contra | Permite nulo, Default: 0, Valores: 0 (normal), 1 (gol contra) |