# Card Crawl V2

This is yet another attempt at making a card-based TTRPG.

## BACKLOG

TODO
+ create simple spells script
+ make simple spells xlsx
- make 5 enchanted weapons
- create 2-faced spell script
- make 2-faced spells xlsx
- make general items xlsx
- make Tactics attribute
- make 5 enchanted armours


## Project Organization
Uses Squib for card prototyping.
there's a script for every card type. Card sets should output to ./output/<setName>  and numbered accordingly.

## Card Types
###  Ficha de Perícias e Ficha de Progressão

Cartas utilizadas na orientação paisagem com campos a serem preenchidos: nome, conceito, nível de renome, virtuide, defeito. A segunda Ficha de Perícias contém uma série de campos em branco que devem ser preenchidos pelo jogador com habilidades que seu Personagem possui.

### Cartas de Personagem (TODO: find better name)

Descrevem as capacidades do personagem. Cada Personagem possui um Baralho Principal que contém diversas Cartas de Personagem. Dentre elas, os tipos mais comuns:

- Atributo
- Desvantagem
    - Bênção
    - Maldição
    - Exaustão
    - Ferimento Sério
    - Sobrecaga

Sempre que faz um teste, o jogador revela cartas do topo de seu Baralho Principal e cartas do Baralho Principal do Mestre. Dependendo do número de ícones do Atributo relevante (teste de Poder para intimidar, por exemplo) o teste é parcialmente bem-sucedido (1 sucesso), bem-sucedido (2 sucessos) ou decisivamente bem-sucedido (3+ sucessos)

Ao atacar, o jogador revela cartas do topo de seu Baralho Principal e cartas do Baralho principal do Mestre. Dependendo do número de ícones de Ataque, causa dano com sua arma. Cada instância de dano é reduzida pela Armadura do Alvo. O número de cartas compradas do Baralho Principal do Jogador é reduzido pela Esquiva do alvo.

### Equipment Gear and Spell
Descrevem equipamentos de aventura e itens vestidos ou carregados por jogadores

### Health/Wound tracker
Descrevem a saúde geral do personagem. Possui frente e verso.

Frente: indica um ponto de vida saudável
Verso: indica um ferimento, pode conter um ferimento ou cicatriz permantente.

<!-- ### Supply tracking NÃO FAZ SENTIDO MAIS. ENCUMBRANCE É REPRESENTADO COMO CARTAS-LIXO NO BARALHO PRINCIPAL-->

### Item (inventário)

Descrevem itens carregados ou equipamentos vestidos ou utilizados pelos Personagens. Ficam na mesa, à mostra, e possuem várias palavras-chave e subtipos diferentes.

- Item (pode ocupar um dos slots do personagem (cabeça, peito, pés, mãos, 3 amuletos, TODO: pensar se só isso ))
    - Arma (espada, lança, adaga)
    - Armadura (cota de malha, escudo, elmo)
    - Vestes (roupas)
    - Acessório
    - Ferramenta (pé-de-cabra, lanterna)
    - Miscelânea (corda, perfume, giz)
    - Tesouro

Alguns itens possuem palavras-chave como Robusto, Frágil, Valioso. Uma das mais importantes é Carga X, que dita quantas cartas de Sobrecarga devem ser adicionadas ao Baralho Principal do Personagem enquanto carregar tal item consigo.

### Aliado
Representa um personagem secundário que segue e obedece o Personagem do Jogador. Descreve, em termos simplificados, suas características.

### Traços
Características e habilidades inatas dos Personagens.
