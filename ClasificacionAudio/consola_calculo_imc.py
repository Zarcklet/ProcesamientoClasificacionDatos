import calculadora_indice as calc

def ejecutar_IMC(peso: float, altura: float) -> None:
    IMC = calc.calcular_IMC(peso, altura)
    print('El índice de masa corporal de esta persona es de', round(IMC, 2))


def iniciar_aplicacion() -> None:
    print('Esta función calcula el índice de masa corporal de una persona')
    peso = float(input('Ingrese el peso de la persona (kg): '))
    altura = float(input('Ingrese la altura de la persona (m): '))
    ejecutar_IMC(peso, altura)

iniciar_aplicacion()






