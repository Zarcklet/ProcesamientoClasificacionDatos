import calculadora_indice as calc

def ejecutar_TMB(peso: float, altura: float, edad: int, valor_genero: int) -> None:
    TMB = calc.calcular_calorias_en_reposo(peso, altura, edad, valor_genero)
    print('La cantidad de calorías quema estando en reposo esta persona es de ', round(TMB, 2), 'cal')


def iniciar_aplicacion() -> None:
    print('Esta función calcula la cantidad de calorías que una persona quema estando en reposo')
    peso = float(input('Ingrese el peso de la persona (kg): '))
    altura = float(input('Ingrese la altura de la persona (m): '))
    edad = int(input('Ingrese la edad de la persona (años): '))
    valor_genero = int(input('Ingrese el valor 5 para masculino y -161 para femenino: '))
    
    ejecutar_TMB(peso, altura, edad, valor_genero)

iniciar_aplicacion()