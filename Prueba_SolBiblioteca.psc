Algoritmo Biblioteca_Sun
    //- Definirs
    Definir cantidad_prestamos, cantidad_devoluciones, op_menu, i Como Entero
    Definir multas_generadas Como Real
    Definir prest_usuario Como Caracter
    Definir prest_codigo, prest_dias, prest_cant Como Entero
    Definir prest_devuelto Como Logico
	
    //- Dimensiones
    Dimension prest_usuario[100]
    Dimension prest_codigo[100], prest_dias[100], prest_cant[100]
    Dimension prest_devuelto[100]
	
    //- Contadores y variables
    cantidad_prestamos <- 0
    cantidad_devoluciones <- 0
    multas_generadas <- 0
    op_menu <- 0
	
    //- Comienzo en los arreglos
    Para i <- 1 Hasta 100 Hacer
        prest_usuario[i] <- ''
        prest_codigo[i] <- 0
        prest_dias[i] <- 0
        prest_cant[i] <- 0
        prest_devuelto[i] <- Falso
    FinPara
	
    //- Menu principal 
    Mientras op_menu <> 4 Hacer
        Limpiar Pantalla
        Escribir '.................................'
        Escribir '   Bienvenido a Biblioteca Sun'
        Escribir '.................................'
        Escribir '       MENU PRINCIPAL'
        Escribir '1. Registrar prestamo'
        Escribir '2. Registrar devolucion'
        Escribir '3. Reportes'
        Escribir '4. Salir'
        Escribir 'Seleccione una opcion:'
        Leer op_menu
		
        Segun op_menu Hacer
            1:
                RegistrarPrestamo(cantidad_prestamos, prest_usuario, prest_codigo, prest_dias, prest_cant, prest_devuelto)
            2:
                RegistrarDevolucion(cantidad_devoluciones, multas_generadas, cantidad_prestamos, prest_usuario, prest_codigo, prest_dias, prest_cant, prest_devuelto)
            3:
                GenerarReporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
            4:
                Limpiar Pantalla
                Escribir '...........................'
                Escribir '      REPORTE FINAL'
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Escribir 'Total de multas generadas: ', multas_generadas
                Escribir 'Gracias por utilizar Biblioteca Sun.'
                Esperar Tecla
            De Otro Modo:
                Escribir 'Error: seleccione una opcion del 1 al 4.'
                Esperar Tecla
        FinSegun
    FinMientras
FinAlgoritmo


//- Funcion 1:Validar dias
//-Su funcion es: Poder llevar un registro de dias con base lo que el usuario comenta
Funcion dias_validos <- ValidarDias()
    Definir dias_validos Como Entero
	
    Repetir
        Escribir 'Ingrese la cantidad de dias:'
        Leer dias_validos
		
        Si dias_validos <= 0 Entonces
            Escribir 'Error: debe ingresar un numero mayor que cero.'
        FinSi
    Hasta Que dias_validos > 0
FinFuncion


//- Funcion 2: Multas
//-Su funcion es: Calcular las multas por dias de atraso 
Funcion multa_calculada <- CalcularMulta(dias_atraso)
    Definir multa_calculada Como Real
    Definir tramo, tarifa Como Entero
	
    multa_calculada <- 0
    tramo <- 0
    tarifa <- 0
	
    Si dias_atraso > 0 Entonces
        Si dias_atraso <= 5 Entonces
            tramo <- 1
        Sino
            Si dias_atraso <= 10 Entonces
                tramo <- 2
            Sino
                tramo <- 3
            FinSi
        FinSi
		
        Segun tramo Hacer
            1:
                tarifa <- 500
            2:
                tarifa <- 750
            3:
                tarifa <- 1000
        FinSegun
		
        multa_calculada <- dias_atraso * tarifa
    FinSi
FinFuncion


//- SubProceso 1
//-Su funcion es: Verificar la forma correcta de registrar un prestamo
SubProceso RegistrarPrestamo(cantidad_prestamos Por Referencia, prest_usuario Por Referencia, prest_codigo Por Referencia, prest_dias Por Referencia, prest_cant Por Referencia, prest_devuelto Por Referencia)
    Definir usuario Como Caracter
    Definir codigo, dias, cantidad_libros, i Como Entero
	
    Limpiar Pantalla
    Escribir '...... REGISTRAR PRESTAMO ......'
	
    Si cantidad_prestamos >= 100 Entonces
        Escribir 'Error: se alcanzo el limite de prestamos.'
        Esperar Tecla
    Sino
        //- Validacion del nombre del usuario
        Repetir
            Escribir 'Ingrese el nombre del usuario:'
            Leer usuario
			
            Si usuario = '' Entonces
                Escribir 'Error: el nombre no puede quedar vacio.'
            FinSi
        Hasta Que usuario <> ''
		
        //- Validacion del codigo del prestamo
        Repetir
            Escribir 'Ingrese el codigo del prestamo:'
            Leer codigo
			
            Si codigo <= 0 Entonces
                Escribir 'Error: el codigo debe ser mayor que cero.'
            Sino
                Para i <- 1 Hasta cantidad_prestamos Hacer
                    Si prest_codigo[i] = codigo Entonces
                        Escribir 'Error: ese codigo ya fue utilizado.'
                        codigo <- 0
                    FinSi
                FinPara
            FinSi
        Hasta Que codigo > 0
		
        //- Registro de los dias del prestamo
        dias <- ValidarDias()
		
        //- Validacion de la cantidad de libros
        Repetir
            Escribir 'Cantidad de libros (entre 1 y 3):'
            Leer cantidad_libros
			
            Si cantidad_libros < 1 O cantidad_libros > 3 Entonces
                Escribir 'Error: debe ingresar entre 1 y 3 libros.'
            FinSi
        Hasta Que cantidad_libros >= 1 Y cantidad_libros <= 3
		
        //- Memoria de los datos en la ventana de prestamos
        cantidad_prestamos <- cantidad_prestamos + 1
        prest_usuario[cantidad_prestamos] <- usuario
        prest_codigo[cantidad_prestamos] <- codigo
        prest_dias[cantidad_prestamos] <- dias
        prest_cant[cantidad_prestamos] <- cantidad_libros
        prest_devuelto[cantidad_prestamos] <- Falso
		
        //- Afirmacion del prestamo
        Escribir ' '
        Escribir 'Prestamo registrado correctamente.'
        Escribir 'Usuario: ', usuario
        Escribir 'Codigo del prestamo: ', codigo
        Escribir 'Dias del prestamo: ', dias
        Escribir 'Cantidad de libros: ', cantidad_libros
        Escribir 'Total de prestamos registrados: ', cantidad_prestamos
        Esperar Tecla
    FinSi
FinSubProceso


//- SubProceso 2: Devolucion
//-Su funcion es: Registrar la devolucion de libros
SubProceso RegistrarDevolucion(cantidad_devoluciones Por Referencia, multas_generadas Por Referencia, cantidad_prestamos, prest_usuario, prest_codigo, prest_dias, prest_cant, prest_devuelto Por Referencia)
    Definir codigo, posicion, op_atraso, dias_atraso Como Entero
    Definir multa Como Real
    Definir i Como Entero
	
    Limpiar Pantalla
    Escribir '...... REGISTRO DE DEVOLUCION ......'
	
    //- Verificacion de prestamos pendientes
    Si cantidad_devoluciones >= cantidad_prestamos Entonces
        Escribir 'No hay prestamos pendientes.'
        Esperar Tecla
    Sino
        posicion <- 0
		
        //- Busqueda y validacion 
        Repetir
            Escribir 'Digite el codigo del prestamo que desea devolver:'
            Leer codigo
			
            Si codigo > 0 Entonces
                Para i <- 1 Hasta cantidad_prestamos Hacer
                    Si prest_codigo[i] = codigo Entonces
                        posicion <- i
                    FinSi
                FinPara
            FinSi
			
            Si posicion = 0 Entonces
                Escribir 'Error: no existe un prestamo con ese codigo.'
            Sino
                Si prest_devuelto[posicion] Entonces
                    Escribir 'Error: ese prestamo ya fue devuelto.'
                    posicion <- 0
                FinSi
            FinSi
        Hasta Que posicion > 0
		
        //- Consulta sobre los dias de atraso
        Repetir
            Escribir 'La devolucion tiene dias de atraso?'
            Escribir '1. Si'
            Escribir '2. No'
            Leer op_atraso
			
            Si op_atraso <> 1 Y op_atraso <> 2 Entonces
                Escribir 'Error: seleccione 1 o 2.'
            FinSi
        Hasta Que op_atraso = 1 O op_atraso = 2
		
        //- Registro de los dias de atraso
        Si op_atraso = 1 Entonces
            dias_atraso <- ValidarDias()
        Sino
            dias_atraso <- 0
        FinSi
		
        //- Calculo y acumulacion de la multa
        multa <- CalcularMulta(dias_atraso)
        multas_generadas <- multas_generadas + multa
		
        //- Actualizacion de la devolucion
        cantidad_devoluciones <- cantidad_devoluciones + 1
        prest_devuelto[posicion] <- Verdadero
		
        //- Comprobante de devolucion
        Escribir 'Devolucion registrada correctamente.'
        Escribir 'Usuario: ', prest_usuario[posicion]
        Escribir 'Codigo del prestamo: ', prest_codigo[posicion]
        Escribir 'Cantidad de libros: ', prest_cant[posicion]
        Escribir 'Dias del prestamo: ', prest_dias[posicion]
        Escribir 'Dias de atraso: ', dias_atraso
		
        //- Resultado de la multa
        Si multa > 0 Entonces
            Escribir 'Multa de esta devolucion: ', multa
        Sino
            Escribir 'Devolucion a tiempo, no tiene multa.'
        FinSi
		
        //- Totales 
        Escribir 'Total acumulado de multas: ', multas_generadas
        Escribir 'Total de devoluciones: ', cantidad_devoluciones
        Esperar Tecla
    FinSi
FinSubProceso


//- SubProceso 3: Reportes
//- Su funcion es: Verificar y corroborar los reportes asignados
SubProceso GenerarReporte(cantidad_prestamos, cantidad_devoluciones, multas_generadas)
    Definir op_reporte Como Entero
    Definir promedio_multas Como Real
	
    //- Menu de reportes
    Repetir
        Limpiar Pantalla
        Escribir '......... GENERAR REPORTES .........'
        Escribir '1. Cantidad de prestamos'
        Escribir '2. Cantidad de devoluciones'
        Escribir '3. Total de multas'
        Escribir '4. Reporte general'
        Escribir '5. Volver al menu principal'
        Escribir 'Seleccione una opcion:'
        Leer op_reporte
		
        //- Seleccion del reporte 
        Segun op_reporte Hacer
            1:
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Esperar Tecla
            2:
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Esperar Tecla
            3:
                Escribir 'Total acumulado de multas: ', multas_generadas
                Esperar Tecla
            4:
                //- Presentacion del reporte 
                Escribir '......... REPORTE GENERAL .........'
                Escribir 'Total de prestamos: ', cantidad_prestamos
                Escribir 'Total de devoluciones: ', cantidad_devoluciones
                Escribir 'Total acumulado de multas: ', multas_generadas
				
                //- Calculo del promedio de multas
                Si cantidad_devoluciones > 0 Entonces
                    promedio_multas <- multas_generadas / cantidad_devoluciones
                    Escribir 'Promedio de multa por devolucion: ', promedio_multas
                Sino
                    Escribir 'Promedio de multa: no disponible'
                    Escribir 'No se han registrado devoluciones.'
                FinSi
				
                Esperar Tecla
            5:
                Escribir 'Regresando al menu principal.'
            De Otro Modo:
                Escribir 'Error: seleccione una opcion del 1 al 5.'
                Esperar Tecla
        FinSegun
    Hasta Que op_reporte = 5
FinSubProceso