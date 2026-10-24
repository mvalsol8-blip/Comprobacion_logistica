//Prueba_SolValerio_22,23/10
//Esta prueba ejecuta la funcion de una biblioteca, pide, presta,devuelve y multa por libro sugerido

Algoritmo Biblioteca_Sun
//-Definiciones del algoritmo
Definir cantidad_prestamos, cantidad_devoluciones, op_menu Como Entero
Definir multas_generadas Como Real

//-Contadores y acumuladores
cantidad_prestamos <- 0
cantidad_devoluciones <- 0
multas_generadas <- 0
op_menu <- 0

//-Pantalla de bienvenida 
//-Ciclo y ejecucion
Mientras op_menu <> 4 Hacer
	Limpiar Pantalla
	Escribir '.................................'
	Escribir '   Bienvenido a Biblioteca Sun   '
	Escribir '.................................'
	Escribir '   MENÚ PRINCIPAL:     '
	Escribir '1. Registrar prestamo'
	Escribir '2. Registrar devolucion'
	Escribir '3. Reportes'
	Escribir '4. Salir'
	Escribir 'Selecciona una opcion:'
	Escribir 'Pili linda'
	Leer op_menu
	
	Segun op_menu Hacer
		1:
			registrar_prestamo(cantidad_prestamos)
		2:
			registrar_devolucion(cantidad_devoluciones, multas_generadas)
		3:
			generar_reporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
		4:
			Limpiar Pantalla
			Escribir '========================================'
			Escribir 'Gracias por utilizar Biblioteca Sun.'
			Escribir 'Saliendo del sistema...'
			Escribir '========================================'
			
		De Otro Modo:
			Escribir 'Error: Seleccione una opcion del 1 al 4'
			Esperar Tecla
	FinSegun
FinMientras
FinAlgoritmo

//Funcion 1: Validar dias del prestamo
//Su funcion: Recibe la cantidad de dias que ingresa el usuario, verifica que sea mayor que 0 y devuelve los dias validos
Funcion dias_validos <- validar_dias 
Definir dias_validos Como Entero	
Repetir
	Escribir 'Ingrese los dias del prestamo:'
	Leer dias_validos
	Si dias_validos <= 0 Entonces
		Escribir 'Error: Ingrese un numero mayor a cero'
	FinSi
Hasta Que dias_validos > 0
FinFuncion

//Funcion 2: Calcular multa
//Su funcion: Recibe los dias de atraso y devuelve el monto de la multa calculada segun la cantidad de dias

Funcion multa_calculada <- calcular_multa (dias)
Definir multa_calculada Como Real	
Si dias <= 0 Entonces
	multa_calculada <- 0
SiNo
	Segun dias Hacer
		1, 2, 3, 4, 5:
			multa_calculada <- dias * 500
		6, 7, 8, 9, 10:
			multa_calculada <- dias * 750
		De Otro Modo:
			multa_calculada <- dias * 1000
	FinSegun
FinSi
FinFuncion

//Funcion 3: Registrar prestamo
//Su funcion: Recibe el contador de prestamos por referencia, solicita los datos del usuario y los libros seleccionados, registra el prestamo y aumenta el contador

Funcion registrar_prestamo (cantidad_prestamos Por Referencia)
Definir nombre_usuario, nombre_libro, libros_seleccionados Como Caracter
Definir codigo_prestamo, dias_prestamo, cantidad_libros, libro_elegido, i Como Entero

Limpiar Pantalla
Escribir '================================='
Escribir '       Registrar prestamo        '
Escribir '================================='

//Validar el nombre
Escribir 'Ingrese el nombre del usuario:'
Leer nombre_usuario

Mientras nombre_usuario = '' Hacer
	Escribir 'Error: El nombre no puede estar vacio'
	Escribir 'Ingrese el nombre del usuario: '
	Leer nombre_usuario
FinMientras

//Validar codigo
Repetir
	Escribir 'Ingrese el codigo del prestamo:'
	Leer codigo_prestamo 
	Si codigo_prestamo <= 0 Entonces
		Escribir 'Error: El codigo debe ser mayor a cero'
	FinSi
Hasta Que codigo_prestamo > 0

//Solicitar dias
dias_prestamo <- validar_dias

//Validar la cantidad permitida
Repetir
	Escribir 'Cantidad de libros que desea llevar (1 a 3)'
	Leer cantidad_libros
	Si cantidad_libros < 1 O cantidad_libros > 3 Entonces
		Escribir 'Error: Solo puede llevar de 1 a 3 libros'
	FinSi
Hasta Que cantidad_libros >= 1 Y cantidad_libros <= 3

//Iniciar lista de titulos
libros_seleccionados <- ''

//Permite seleccionar cada libro
Para i <- 1 Hasta cantidad_libros Hacer
	Limpiar Pantalla
	Escribir 'Libro ', i, ' de ', cantidad_libros
	Escribir '1. La hipotesis del amor'
	Escribir '2. Enola Holmes y el carruaje negro'
	Escribir '3. Crimen y castigo'
	Escribir '4. Orgullo y prejuicio'
	Escribir '5. Harry Potter y el prisionero de Azkaban'
	Escribir '6. Los juegos del hambre'	
//Validar el numero
	Repetir
		Escribir 'Ingrese el numero del libro: '
		Leer libro_elegido
		Si libro_elegido < 1 O libro_elegido > 6 Entonces
			Escribir 'Error: Seleccione un libro del 1 al 6'
		FinSi
	Hasta Que libro_elegido >= 1 Y libro_elegido <= 6
//Convertir el numero
	Segun libro_elegido Hacer
		1:
			nombre_libro <- 'La hipotesis del amor'
		2:
			nombre_libro <- 'Enola Holmes y el carruaje negro'
		3:
			nombre_libro <- 'Crimen y castigo'
		4:
			nombre_libro <- 'Orgullo y prejuicio'
		5:
			nombre_libro <- 'Harry Potter y el prisionero de Azkaban'
		6:
			nombre_libro <- 'Los juegos del hambre'
	FinSegun
//Guardar el titulo
	libros_seleccionados <- libros_seleccionados + nombre_libro + ', '
FinPara
//Actualizar
cantidad_prestamos <- cantidad_prestamos + 1
//Mostrar el prestamo
Limpiar Pantalla
Escribir '================================='
Escribir '       Registrar prestamo        '
Escribir '================================='
Escribir 'Usuario: ', nombre_usuario
Escribir 'Codigo del prestamo: ', codigo_prestamo
Escribir 'Dias del prestamo: ', dias_prestamo
Escribir 'Cantidad de libros: ', cantidad_libros
Escribir 'Libros seleccionados: '
Escribir libros_seleccionados
Escribir '================================='
Escribir 'Prestamo registrado con exito'
Escribir 'Total de prestamos registrados: ', cantidad_prestamos
Escribir '================================='
Escribir 'Presione la tecla enter para continuar...'
Esperar Tecla
FinFuncion

//Funcion 4: Registrar devolucion
//Su funcion es: Recibir el contador de devoluciones y el acumulador de multas por referencia, solicitando los datos de devolucion, calculando la multa correspondiente y actualizando los valores
Funcion registrar_devolucion (cantidad_devoluciones Por Referencia, multas_generadas Por Referencia)
Definir nombre_usuario Como Caracter
Definir multa Como Real
Definir codigo_prestamo, op_atraso, dias_atraso Como Entero

Limpiar Pantalla
Escribir '================================='
Escribir '       Registrar devolucion      '
Escribir '================================='

//Validar el nombre
Escribir 'Ingrese el nombre del usuario: '
Leer nombre_usuario

Mientras nombre_usuario = '' Hacer
	Escribir 'Error: El nombre no puede estar vacio'
	Escribir 'Ingrese el nombre del usuario: '
	Leer nombre_usuario
FinMientras

//Validar el codigo
Repetir
	Escribir 'Ingrese el codigo del prestamo:'
	Leer codigo_prestamo
	Si codigo_prestamo <= 0 Entonces
		Escribir 'Error: El codigo debe ser mayor a cero'
	FinSi
Hasta Que codigo_prestamo > 0

//Preguntar
Repetir
	Escribir 'La devolucion tiene dias de atraso'
	Escribir '1. Si'
	Escribir '2. No'
	Leer op_atraso
	
	Si op_atraso <> 1 Y op_atraso <> 2 Entonces
		Escribir 'Error: Seleccione 1 o 2'
	FinSi
Hasta Que op_atraso = 1 O op_atraso = 2

//Validar dias
Si op_atraso = 1 Entonces
	Repetir
		Escribir 'Ingrese la cantidad de dias de atraso:'
		Leer dias_atraso
		
		Si dias_atraso <= 0 Entonces
			Escribir 'Error: Los dias de atraso deben ser mayores a cero'
		FinSi
	Hasta Que dias_atraso > 0
SiNo
	dias_atraso <- 0
FinSi

//Calcular la multa
multa <- calcular_multa (dias_atraso)

//Acumular el monto
multas_generadas <- multas_generadas + multa

//Actualizar el contador
cantidad_devoluciones <- cantidad_devoluciones + 1

//Mostrar el comprobante
Escribir '================================='
Escribir '       Registrar devolucion      '
Escribir '================================='
Escribir 'Usuario: ', nombre_usuario
Escribir 'Codigo del prestamo: ', codigo_prestamo
Escribir 'Dias de atraso: ', dias_atraso

Si multa > 0 Entonces
	Escribir 'Multa de esta devolucion: ', multa
SiNo
	Escribir 'Devolucion a tiempo, no tiene multa'
FinSi

Escribir 'Total acumulado de multas: ', multas_generadas
Escribir 'Total de devoluciones: ', cantidad_devoluciones
Escribir 'Devolucion registrada correctamente'
Escribir '================================='
Escribir 'Presiona tecla enter para continuar...'
Esperar Tecla
FinFuncion

//Funcion 5: Generar reportes
//Su funcion es: Recibir los totales de prestamos, devoluciones y multas para mostrarlos en los reportes
Funcion generar_reporte (cantidad_prestamos, cantidad_devoluciones, multas_generadas)
	Definir op_reporte Como Entero	
	Definir promedio_multas Como Real

//Ciclo Repetir
Repetir
	Limpiar Pantalla
	Escribir '================================='
	Escribir '         Generar reportes        '
	Escribir '================================='
	Escribir '1. Cantidad de prestamos'
	Escribir '2. Cantidad de devoluciones'
	Escribir '3. Total de multas'
	Escribir '4. Reporte general'
	Escribir '5. Volver al menu principal'
	Escribir 'Seleccione una opcion: '
	Leer op_reporte
	
//Mostrar el reporte	
	Segun op_reporte Hacer
		1:
			Escribir 'Total de prestamos: ', cantidad_prestamos
			
		2:
			Escribir 'Total de devoluciones: ', cantidad_devoluciones
			
		3:
			Si multas_generadas = 0 Entonces
				Escribir 'No se han generado multas.'
			SiNo
				Escribir 'Total acumulado de multas: ', multas_generadas
			FinSi
			
		4:
			Limpiar Pantalla
			Escribir '=========== REPORTE GENERAL ============='
			Escribir 'Total de prestamos: ', cantidad_prestamos
			Escribir 'Total de devoluciones: ', cantidad_devoluciones
			Escribir 'Total acumulado de multas: ', multas_generadas
			
			Si cantidad_devoluciones > 0 Entonces
				promedio_multas <- multas_generadas / cantidad_devoluciones
				Escribir 'Promedio de multa por devolucion: ', promedio_multas
			SiNo
				Escribir 'Promedio de multa: No disponible'
				Escribir 'Aun no se han registrado devoluciones'
			FinSi
			Escribir '========================================'
			
		5:
			Escribir 'Regresando al menu principal...'

		De Otro Modo:
			Escribir 'Error: Seleccione una opcion del 1 al 5'
	FinSegun
	
//Pausar 	
	Si op_reporte <> 5 Entonces
		Esperar Tecla
	FinSi
Hasta Que op_reporte = 5
	
FinFuncion