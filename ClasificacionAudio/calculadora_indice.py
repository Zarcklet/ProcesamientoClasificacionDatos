

def convertir_cm(metros: float) -> float:
    '''
    Calcula de metros a centímetros.
    '''
    return metros*100

def calcular_IMC(peso: float, altura: float) -> float:
    '''
    Calcula el índice de masa corporal de una persona.
    '''
    return peso/(altura**2)

def calcular_porcentaje_grasa(peso: float, altura: float, edad: int, valor_genero: float) -> float:
    '''
    Calcula el porcentaje de grasa de una persona a partir de la ecuación
    definida anteriormente.
    '''
    return 1.2*calcular_IMC(peso, altura)+0.23*edad-5.4-valor_genero

def calcular_calorias_en_reposo(peso: float, altura: float, edad: int, valor_genero: int) -> float:
    '''
    Calcula la cantidad de calorías que una persona quema estando en reposo
    (esto es, su tasa metabólica basal), a partir de la ecuación definida anteriormente.
    '''
    return (10*peso)+(6.25*convertir_cm(altura))-(5*edad)+valor_genero

def calcular_calorias_en_actividad(peso: float, altura: float, edad: int, valor_genero: int, valor_actividad: float) -> float:
    '''
    Calcula la cantidad de calorías que una persona quema al realizar algún tipo
    de actividad física (esto es, su tasa metabólica basal según actividad física),
    a partir de la ecuación definida anteriormente.
    '''
    return calcular_calorias_en_reposo(peso, altura, edad, valor_genero)*valor_actividad

def consumo_calorias_recomendado_para_adelgazar(peso: float, altura: float, edad: int, valor_genero: int) -> str:
    '''
    Calcula el rango de calorías recomendado, que debe consumir una persona
    diariamente en caso de que desee adelgazar, a partir de la ecuación
    definida anteriormente.
    '''
    inferior = calcular_calorias_en_reposo(peso, altura, edad, valor_genero)*0.8
    superior = calcular_calorias_en_reposo(peso, altura, edad, valor_genero)*0.85
    print('Para adelgazar es recomendado que consumas entre', round(inferior, 2), 'y', round(superior, 2), 'calorías al día.')
    


