Algoritmo Biblioteca_sun 
//-Definiciones del algoritmo
	Definir cantidad_prestamos, cantidad_devoluciones, op_menu Como Entero
	Definir multas_generadas Como Real
	
//-Contadores y acumuladores
cantidad_prestamos <- 0
cantidad_devoluciones <- 0
multas_generadas <- 0
op_menu <- 0	

//-Pantalla de bienvenida, ciclo y ejecucion
Mientras op_menu <> 5 Hacer
	Limpiar Pantalla
	Escribir '.................................'
	Escribir '   Bienvenido a Biblioteca Sun   '
	Escribir '.................................'
	Escribir '   MENÚ PRINCIPAL:     '
	Escribir '1. Registrar prestamo'
	Escribir '2. Registrar devolucion'
	Escribir '3. Reportes'
	Escribir '4. Salir'
	Escribir '5. Consultar reglas de prestamo'
	op_menu <- leer_entero('Seleccione una opcion: ')
	
	Segun op_menu Hacer
		1:
			registrar_prestamo(cantidad_prestamos)
		2:
			registrar_devolucion(cantidad_devoluciones, multas_generadas)
		3:
			generar_reporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
		4:
			Limpiar Pantalla
			Escribir '...........................'
			Escribir '...... REPORTE FINAL ......'
			Escribir 'Total de prestamos: ', cantidad_prestamos
			Escribir 'Total de devoluciones: ', cantidad_devoluciones
			Escribir 'Total de multas generadas: ', multas_generadas
			Escribir 'Gracias por utilizar Biblioteca Sun."
			Esperar Tecla
		5:
			Limpiar Pantalla
			Escribir '................................'
			Escribir '...... REGLAS DE PRESTAMO ......'
			Escribir '1. Se pueden seleccionar de 1 a 3 libros.'
			Escribir '2. Los dias de prestamo deben ser mayores que cero.'
			Escribir '3. Las multas dependen de los dias de atraso.'
		De Otro Modo:
			Escribir 'Error: Seleccione una opcion del 1 al 5'
			Esperar Tecla
	FinSegun
FinMientras
FinAlgoritmo	
	
//-Inicio de funciones

//-Funcion 1: Inicio numerico
//-Su funcion: Leer el dato como texto y lo convierta
Funcion punto_num <- leer_total (mensaje)
	Definir punto_num Como Entero
	Definir entrada Como Caracter
	
	Repetir
		Escribir mensaje
		Leer entrada
		Si punto_num(entrada) Entonces
			punto_num <- ConvertirANumero(entrada)
		SiNo
			punto_num <- -1
			Escribir 'Denegado: Digite solamente numeros completos'
		Fin Si
	Hasta Que punto_num(entrada)
	
Fin Funcion

//Funcion 2: Comprobar el inicio numerico
//Su funcion: Devolver el Verdadero si los digitos son del 0 al 9
Funcion resultado <- es_num (texto)
	Definir resultado, encontrado Como Logico
	Definir digitos, letras Como Caracter
	Definir i, j Como Entero
	digitos <- '0123456789'
	resultado <- Verdadero
	
	Si Longitud(texto) = 0 Entonces
		resultado <- Falso
	SiNo
		Para i <- 0 Hasta Longitud(texto) - 1 Hacer
			letras <- Subcadena(texto, i, i)
			encontrado <- Falso
			
			Para j <- 0 Hasta 9 Hacer
				Si letras = Subcadena(digitos, j, j) Entonces
					encontrado <- Verdadero
				FinSi
				
			Fin Para
			
			Si encontrado = Falso Entonces
				resultado <- Falso
			Fin Si
		Fin Para
		
	Fin Si
	
Fin Funcion

//-Funcion 3: Validar los dias del prestamo
//Su funcion: Recibe la cantidad de dias, verifica que sea mayor que 0 y devuelve los dias validos
Funcion dias_validos <- validar_dias 
Definir dias_validos Como Entero	

Repetir
	dias_validos <- leer_entero('Ingrese la cantidad de dias: ')
	
	Si dias_validos <= 0 Entonces
		Escribir 'Denegado: Los dias deben ser mayor a 0'
	Fin Si
	
Hasta Que dias_validos > 0
Fin Funcion

//-Funcion 4: Calcular multa
//-Su funcion es: Calcular la multa de los dias atrasados
Funcion multa_calculada <- calcular_multa (dias)
	Definir multa_calculada
	Si dias <= 0  Entonces
		multa_calculada <- 0
	SiNo
		Si dias <= 5 Entonces
			multa_calculada <- dias * 500
		SiNo
			Si dias <= 10 Entonces
				multa_calculada <- dias * 750
			SiNo
				multa_calculada <- dias * 1000
			Fin Si
		Fin Si
	Fin Si
Fin Funcion

//- Subproceso 1: Registra prestamo
SubProceso registrar_prestamo(cantidad_prestamos Por referencia)
	//- Defino las variables 
	Definir nombre_usuario, nombre_libro, libros_seleccionados Como Caracter
	Definir codigo_prestamo, dias_prestamo, cantidad_libros, libro_elegido, i Como Entero
	
	Limpiar Pantalla
	Escribir '...... Registrar prestamo ......'
	Escribir '................................'
	
	//-Verificando nombre
	Repetir
		Escribir 'Ingrese el nombre del usuario: '
		Leer nombre_usuario
		
		Si nombre_usuario = '' Entonces
			Escribir 'Denegado: El nombre no debe estar vacio'
		Fin Si
		
	Hasta Que nombre_usuario <> ''
	
	//-Verificando codigo
	Repetir
		codigo_prestamo <- leer_entero ('Ingrese el codigo del prestamo: ')
		
		Si codigo_prestamo <= 0 Entonces
			Escribir 'Denegado: El codigo debe ser mayor que cero'
		Fin Si
		
	Hasta Que codigo_prestamo > 0
	
	//-Verificando dias
	dias_prestamo <- validar_dias
	
	//-Verificando cantidad de libros
	Repetir
		cantidad_libros <- leer_entero('Cantidad de libros que desea llevar (1 a 3): ')
		
		Si cantidad_libros < 1 O cantidad_libros > 3 Entonces
			Escribir 'Denegado: Solo puedes escoger de 1 a 3 libros'
		Fin Si
		
	Hasta Que cantidad_libros >= 1 Y cantidad_libros <= 3
	
	//-Comenzar lista de libros
	libros_seleccionados <- ''
	
	//-Elegir libros
	Para i <- 1 Hasta cantidad_libros Hacer
		Limpiar Pantalla
		Escribir 'Libro ', i, 'de ', cantidad_libros
		Escribir '1. La hipotesis del amor '
		Escribir '2. Enola Holmes y el carruaje negro'
		Escribir '3. Crimen y castigo'
		Escribir '4. Orgullo y prejuicio'
		Escribir '5. Harry Potter y el prisionero de Azkaban'
		Escribir '6. Los juegos del hambre'
		
		//-Verificando seleccion
		Repetir
			libro_escogido <- leer_entero('Digita el numero del libro: ')
			Si libro_elegido < 1 O libro_elegido > 6 Entonces
				Escribir 'Denegado: Seleccione un libro del 1 al 6: '
			Fin Si
		Hasta Que libro_elegido >= 1 Y libro_elegido <= 6
		
		//-Definiendo titulo
		Segun libro_escogido Hacer
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
		Fin Segun
		
		//-Añadiendo titulo
		libros_seleccionados <- libros_seleccionados + nombre_libro + ', '
		
	Fin Para
	
	//Actualizando contador
	cantidad_prestamos <- cantidad_prestamos + 1
	
	//Enseñar comprobante
	Limpiar Pantalla
	Escribir '...... PRESTAMO REGISTRADO ......'
	Escribir '.................................'
	Escribir 'Usuario: ', nombre_usuario
	Escribir 'Codigo del prestamo: ', codigo_prestamo
	Escribir 'Dias del prestamo: ', dias_prestamo
	Escribir 'Cantidad de libros: ', cantidad_libros
	Escribir 'Libros escogidos: '
	Escribir libros_seleccionados
	Escribir 'Total de prestamos registrados: ', cantidad_prestamos
	Escribir '.................................'
	Escribir 'Escoje una tecla para continuar'
	Esperar Tecla
FinSubProceso

//-Subproceso 2: Registrar devolucion
SubProceso registrar_devolucion(cantidad_devoluciones Por Referencia, multas_generadas Por Referencia)
//Diseñando definirs	
	Definir nombre_usuario Como Caracter
	Definir multa Como Logico
	Definir codigo_prestamo, op_atraso, dias_atraso Como Entero
	Limpiar Pantalla
	Escribir '...... REGISTRO DE DEVOLUCION ......'
	Escribir '....................................'
	
	//Verificando
	Repetir
		Escribir 'Digite el nombre del usuario: '
		Leer nombre_usuario
		Si nombre_usuario = '' Entonces
			Escribir 'Denegado: El nombre no puede estar vacio'
		Fin Si
	Hasta Que nombre_usuario <> ''
	
	//-Verificando codigo
	Repetir
		codigo_prestamo <- leer_entero('Digite el codigo del prestamo: ')
		Si codigo_prestamo <= 0 Entonces
			Escribir 'Denegado: el codigo debe ser mayor que cero'
		Fin Si
	Hasta Que codigo_prestamo > 0
	
	//-Consultar sobre atrasos
	Repetir
		Escribir '¿La devolucion tiene dias de atraso?'
		Escribir '1. Si'
		Escribir '2. No'
		op_atraso <- leer_entero('Escoja una opcion: ')
		
		Si op_atraso <> 1 Y op_atraso <> 2 Entonces
			Escribir 'Denegado: Seleccione 1 o 2'
		Fin Si
		
	Hasta Que op_atraso = 1 O op_atraso = 2
	
	//-Verificar dias de atraso
	Si op_atraso = 1 Entonces
		dias_atraso <- validar_dias
	SiNo
		dias_atraso <- 0
	Fin Si
	
	//-Verificar multa
	multa <- calcular_multa(dias_atraso)
	//Acumular multas
	multas_generadas <- multas_generadas + multa
	//Actualizar devoluciones
	cantidad_devoluciones <- cantidad_devoluciones + 1
	
	//Mostrar comprobante
	Limpiar Pantalla
	Escribir '...... REGISTRO DE DEVOLUCION ......'
	Escribir '....................................'
	Escribir 'Usuario: ', nombre_usuario
	Escribir 'Codigo del prestamo: ', codigo_prestamo
	Escribir 'Dias de atraso: ', dias_atraso
	
	Si multa > 0 Entonces
		Escribir 'Multa de esta devolucion: ', multa
	SiNo
		Escribir 'Devolucion a tiempo, no tiene multa'
	Fin Si
	Escribir 'Total acumulado de multas: ', multas_generadas
	Escribir 'Total de devoluciones: ', cantidad_devoluciones
	Escribir '....................................'
	Escribir 'Escoja una tecla para continuar'
	Esperar Tecla
FinSubProceso

