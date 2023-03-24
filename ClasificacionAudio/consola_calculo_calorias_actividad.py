import calculadora_indice as calc

def ejecutar_TMB_act(peso: float, altura: float, edad: int, valor_genero: int, valor_actividad: float) -> None:
    TMB_act = calc.calcular_calorias_en_actividad(peso, altura, edad, valor_genero, valor_actividad)
    print('La cantidad de calorías quema al realizar algún tipo de actividad física esta persona es de ', round(TMB_act, 2), 'cal')


def iniciar_aplicacion() -> None:
    print('Esta función calcula la cantidad de calorías que una persona quema al realizar algún tipo de actividad física')
    peso = float(input('Ingrese el peso de la persona (kg): '))
    altura = float(input('Ingrese la altura de la persona (m): '))
    edad = int(input('Ingrese la edad de la persona (años): '))
    valor_genero = int(input('Ingrese el valor 5 para masculino y -161 para femenino: '))
    print('\n')
    print('Actividades:')
    print('1.2 - poco o ningún ejercicio')
    print('1.375 - ejercicio ligero (1 a 3 días a la semana)')
    print('1.55 - ejercicio moderado (3 a 5 días a la semana)')
    print('1.72 - deportista (6 -7 días a la semana)')
    print('1.9 - atleta (entrenamientos mañana y tarde)')
    print('\n')
    valor_actividad = float(input('Ingrese el valor de la actividad que realiza: '))

    ejecutar_TMB_act(peso, altura, edad, valor_genero, valor_actividad)

iniciar_aplicacion()