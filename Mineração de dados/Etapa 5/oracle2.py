import streamlit as st
import pandas as pd
import joblib
import numpy as np
import os
from PIL import Image
import matplotlib.pyplot as plt
import plotly.express as px

# Configuração da página
st.set_page_config(
    page_title="Oráculo de Predição de Partidas",
    page_icon="⚽",
    layout="wide"
)

# Estilo CSS personalizado
st.markdown("""
<style>
    .main-title {
        font-size: 42px;
        font-weight: bold;
        color: #1E3A8A;
        text-align: center;
        margin-bottom: 30px;
    }
    .subtitle {
        font-size: 24px;
        font-weight: bold;
        color: #2563EB;
        margin-top: 20px;
        margin-bottom: 10px;
    }
    .result-box {
        background-color: #F3F4F6;
        padding: 20px;
        border-radius: 10px;
        margin-top: 20px;
        margin-bottom: 20px;
        border-left: 5px solid #2563EB;
    }
    .prediction {
        font-size: 28px;
        font-weight: bold;
        text-align: center;
        margin: 20px 0;
    }
    .team-info {
        font-size: 18px;
        margin-bottom: 5px;
    }
    .footer {
        text-align: center;
        margin-top: 50px;
        color: #6B7280;
        font-size: 14px;
    }
</style>
""", unsafe_allow_html=True)


# Função para carregar o modelo
@st.cache_resource
def load_model():
    try:
        # Tenta carregar o Random Forest primeiro
        model_path = 'random_forest_model.pkl'
        if os.path.exists(model_path):
            model = joblib.load(model_path)
            model_name = "Random Forest"
        else:
            # Modelo alternativo
            model_path = 'svm_model.pkl'
            if os.path.exists(model_path):
                model = joblib.load(model_path)
                model_name = "SVM"
            else:
                # Cria um modelo simulado para demonstração
                st.warning("⚠️ Nenhum modelo encontrado. Usando predições simuladas para demonstração.")

                def predict(data):
                    results = []
                    # Lógica simulada mais sofisticada
                    for _, row in data.iterrows():
                        # Mais chances de vitória se tiver mais posse, chutes e gols
                        score = 0
                        if row['PosseDeBola'] == 'alta':
                            score += 2
                        elif row['PosseDeBola'] == 'media':
                            score += 1

                        if row['ChutesAgol'] == 'muitos':
                            score += 2
                        elif row['ChutesAgol'] == 'medios':
                            score += 1

                        if row['Gols'] == '3_ou_mais':
                            score += 3
                        elif row['Gols'] == '2':
                            score += 2
                        elif row['Gols'] == '1':
                            score += 1

                        if score >= 4:
                            results.append("vitoria")
                        elif score >= 2:
                            results.append("empate")
                        else:
                            results.append("derrota")
                    return np.array(results)

                class MockModel:
                    def predict(self, X):
                        return predict(X)

                model = MockModel()
                model_name = "Modelo Simulado (apenas para demonstração)"
    except Exception as e:
        st.error(f"Erro ao carregar o modelo: {str(e)}")

        # Modelo simulado em caso de erro
        def predict(data):
            return np.random.choice(["vitoria", "empate", "derrota"], size=len(data))

        class MockModel:
            def predict(self, X):
                return predict(X)

        model = MockModel()
        model_name = "Modelo Simulado (fallback por erro)"

    return model, model_name


# Título principal
st.markdown('<div class="main-title">⚽ Oráculo de Predição de Partidas</div>', unsafe_allow_html=True)

# Carregar o modelo
model, model_name = load_model()
st.markdown(f"<div style='text-align: center; color: #4B5563;'>Usando o modelo: <b>{model_name}</b></div>",
            unsafe_allow_html=True)

# Sidebar com informações
with st.sidebar:
    st.markdown("### Sobre o Aplicativo")
    st.write("""
    Este aplicativo usa aprendizado de máquina para prever resultados de partidas 
    com base nas estatísticas do jogo. Insira os detalhes da partida e veja a 
    predição do resultado.
    """)

    st.markdown("### Como usar")
    st.write("""
    1. Selecione o time
    2. Escolha os níveis das estatísticas
    3. Clique em "Fazer Predição"
    """)

    # Lógica para mostrar exemplos
    st.markdown("### Exemplos")
    if st.button("Mostrar Exemplos de Predições"):
        st.session_state.show_examples = True

    # Créditos
    st.markdown("---")
    st.markdown('<div class="footer">Desenvolvido por Sergipano Data Insights</div>', unsafe_allow_html=True)

# Definição das opções
teams = ["Sergipe", "Barra", "Dorense", "Falcon", "Lagarto", "America", "Confianca", "Guarany", "Itabaiana",
         "Carmopolis"]
posse_options = ["baixa", "media", "alta"]
escanteios_options = ["poucos", "medios", "muitos"]
chutes_options = ["poucos", "medios", "muitos"]
impedimentos_options = ["nenhum", "alguns", "muitos"]
gols_options = ["0", "1", "2", "3_ou_mais"]

# Verificar se devemos mostrar exemplos
if 'show_examples' not in st.session_state:
    st.session_state.show_examples = False

# Mostrar exemplos se o botão foi clicado
if st.session_state.show_examples:
    st.markdown('<div class="subtitle">Exemplos de Predições</div>', unsafe_allow_html=True)

    # Criar exemplos de partidas
    example_matches = [
        {'NomeTime': 'Confianca', 'PosseDeBola': 'alta', 'Escanteios': 'muitos', 'ChutesAgol': 'muitos',
         'Impedimentos': 'alguns', 'Gols': '3_ou_mais'},
        {'NomeTime': 'Sergipe', 'PosseDeBola': 'media', 'Escanteios': 'medios', 'ChutesAgol': 'poucos',
         'Impedimentos': 'alguns', 'Gols': '0'},
        {'NomeTime': 'Lagarto', 'PosseDeBola': 'alta', 'Escanteios': 'muitos', 'ChutesAgol': 'muitos',
         'Impedimentos': 'muitos', 'Gols': '1'},
        {'NomeTime': 'Itabaiana', 'PosseDeBola': 'baixa', 'Escanteios': 'poucos', 'ChutesAgol': 'poucos',
         'Impedimentos': 'nenhum', 'Gols': '0'}
    ]

    examples_df = pd.DataFrame(example_matches)

    # Fazer predições
    predictions = model.predict(examples_df)

    # Mostrar resultados em uma tabela estilizada
    examples_df['Predição'] = predictions
    examples_df = examples_df.rename(columns={
        'NomeTime': 'Time',
        'PosseDeBola': 'Posse de Bola',
        'Escanteios': 'Escanteios',
        'ChutesAgol': 'Chutes a Gol',
        'Impedimentos': 'Impedimentos',
        'Gols': 'Gols'
    })


    # Criar códigos de cores para resultados
    def highlight_prediction(val):
        color_map = {
            'vitoria': 'background-color: #DCFCE7; color: #166534',
            'empate': 'background-color: #FEF9C3; color: #854D0E',
            'derrota': 'background-color: #FEE2E2; color: #991B1B'
        }
        return color_map.get(val, '')


    st.dataframe(examples_df.style.applymap(highlight_prediction, subset=['Predição']), use_container_width=True)

    # Botão para limpar exemplos
    if st.button("Ocultar Exemplos"):
        st.session_state.show_examples = False
        st.experimental_rerun()

    st.markdown("---")

# Interface principal para predição
st.markdown('<div class="subtitle">Faça sua Predição</div>', unsafe_allow_html=True)

# Criar layout com colunas
col1, col2 = st.columns(2)

with col1:
    team = st.selectbox("Time", teams)
    posse = st.select_slider("Posse de Bola", options=posse_options, value='media')
    escanteios = st.select_slider("Escanteios", options=escanteios_options, value='medios')

with col2:
    chutes = st.select_slider("Chutes a Gol", options=chutes_options, value='medios')
    impedimentos = st.select_slider("Impedimentos", options=impedimentos_options, value='alguns')
    gols = st.select_slider("Gols", options=gols_options, value='1')

# Botão para fazer a predição
if st.button("Fazer Predição", type="primary", use_container_width=True):
    # Criar DataFrame com os dados da partida
    match_data = pd.DataFrame({
        'NomeTime': [team],
        'PosseDeBola': [posse],
        'Escanteios': [escanteios],
        'ChutesAgol': [chutes],
        'Impedimentos': [impedimentos],
        'Gols': [gols]
    })

    # Fazer predição
    prediction = model.predict(match_data)[0]

    # Salvar resultado na session_state
    st.session_state.prediction = prediction
    st.session_state.match_data = match_data

    # Mostrar animação de loading
    with st.spinner("Analisando dados da partida..."):
        # Simulação de processamento
        import time

        time.sleep(1.5)

    # Mostrar resultado
    st.balloons()  # Efeito visual

# Verificar se há uma predição para mostrar
if 'prediction' in st.session_state:
    # Determinar cores e ícones com base na predição
    result_colors = {
        'vitoria': ('#166534', '#DCFCE7', '🏆'),
        'empate': ('#854D0E', '#FEF9C3', '🤝'),
        'derrota': ('#991B1B', '#FEE2E2', '❌')
    }

    color, bg_color, icon = result_colors.get(st.session_state.prediction, ('#1E3A8A', '#DBEAFE', '🔮'))

    # Mostrar resultado em uma caixa estilizada
    st.markdown(f"""
    <div class="result-box" style="background-color: {bg_color};">
        <div class="prediction" style="color: {color};">
            {icon} Resultado Previsto: <span style="text-transform: uppercase;">{st.session_state.prediction}</span>
        </div>
        <div class="team-info">
            <b>Time:</b> {st.session_state.match_data['NomeTime'].values[0]}
        </div>
        <div class="team-info">
            <b>Posse de Bola:</b> {st.session_state.match_data['PosseDeBola'].values[0]}
        </div>
        <div class="team-info">
            <b>Escanteios:</b> {st.session_state.match_data['Escanteios'].values[0]}
        </div>
        <div class="team-info">
            <b>Chutes a Gol:</b> {st.session_state.match_data['ChutesAgol'].values[0]}
        </div>
        <div class="team-info">
            <b>Impedimentos:</b> {st.session_state.match_data['Impedimentos'].values[0]}
        </div>
        <div class="team-info">
            <b>Gols:</b> {st.session_state.match_data['Gols'].values[0]}
        </div>
    </div>
    """, unsafe_allow_html=True)

    # Adicionar gráfico para visualização
    st.markdown('<div class="subtitle">Análise Visual</div>', unsafe_allow_html=True)


    # Criar dados para gráfico de radar
    def map_value_to_numeric(value, options, min_val=1, max_val=5):
        index = options.index(value)
        return min_val + (max_val - min_val) * (index / (len(options) - 1))


    # Mapear valores de categoria para números para visualização
    radar_data = {
        'Categoria': ['Posse de Bola', 'Escanteios', 'Chutes a Gol', 'Impedimentos', 'Gols'],
        'Valor': [
            map_value_to_numeric(st.session_state.match_data['PosseDeBola'].values[0], posse_options),
            map_value_to_numeric(st.session_state.match_data['Escanteios'].values[0], escanteios_options),
            map_value_to_numeric(st.session_state.match_data['ChutesAgol'].values[0], chutes_options),
            map_value_to_numeric(st.session_state.match_data['Impedimentos'].values[0], impedimentos_options),
            map_value_to_numeric(st.session_state.match_data['Gols'].values[0], gols_options)
        ]
    }

    radar_df = pd.DataFrame(radar_data)

    # Criar gráfico usando plotly
    fig = px.line_polar(
        radar_df,
        r='Valor',
        theta='Categoria',
        line_close=True,
        range_r=[0, 5],
        color_discrete_sequence=[color]
    )
    fig.update_traces(fill='toself')
    fig.update_layout(
        polar=dict(
            radialaxis=dict(
                visible=True,
                showticklabels=False
            )
        ),
        showlegend=False
    )

    st.plotly_chart(fig, use_container_width=True)

    # Botão para limpar resultado
    if st.button("Limpar Resultado", use_container_width=True):
        del st.session_state.prediction
        del st.session_state.match_data
        st.rerun()

# Footer
st.markdown("---")
st.markdown('<div class="footer">Sergipano Data Insights © 2025 - Todos os direitos reservados</div>',
            unsafe_allow_html=True)