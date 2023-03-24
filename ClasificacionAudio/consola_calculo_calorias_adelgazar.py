import calculadora_indice as calc

def ejecutar_adelgazar(peso: float, altura: float, edad: int, valor_genero: int) -> None:
    calc.consumo_calorias_recomendado_para_adelgazar(peso, altura, edad, valor_genero)


def iniciar_aplicacion() -> None:
    print('Esta función calcula el rango de calorías recomendado, que debe consumir una persona diariamente en caso de que desee adelgazar')
    peso = float(input('Ingrese el peso de la persona (kg): '))
    altura = float(input('Ingrese la altura de la persona (m): '))
    edad = int(input('Ingrese la edad de la persona (años): '))
    valor_genero = int(input('Ingrese el valor 5 para masculino y -161 para femenino: '))

    ejecutar_adelgazar(peso, altura, edad, valor_genero)

iniciar_aplicacion()