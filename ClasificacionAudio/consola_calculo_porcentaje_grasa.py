import calculadora_indice as calc

def ejecutar_GC(peso: float, altura: float, edad: int, valor_genero: float) -> None:
    GC = calc.calcular_porcentaje_grasa(peso, altura, edad, valor_genero)
    print('El porcentaje de grasa de esta persona es de', str(round(GC, 2))+'%')


def iniciar_aplicacion() -> None:
    print('Esta función calcula el porcentaje de grasa de una persona')
    peso = float(input('Ingrese el peso de la persona (kg): '))
    altura = float(input('Ingrese la altura de la persona (m): '))
    edad = int(input('Ingrese la edad de la persona (años): '))
    valor_genero = float(input('Ingrese el valor 10.8 para masculino y 0 para femenino: '))
    
    ejecutar_GC(peso, altura, edad, valor_genero)

iniciar_aplicacion()