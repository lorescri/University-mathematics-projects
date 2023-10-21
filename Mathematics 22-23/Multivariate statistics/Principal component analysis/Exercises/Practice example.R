
#---------------------ESTUDIO INICIAL DE LOS DATOS-----------------


data()# Trabajamos usando los datos en el "paquete" ejemplos.Rdata

d<-LifeCycleSavings # Guardamos en la variable d los datos que queremos estudiar
#View(d)
help(LifeCycleSavings) # Nos indica que significa cada variable continida en la tabla

#d[,1] = X1  crecimiento ahorros
#d[,2] = X2  pop 15
#d[,3] = X3  pop75
#d[,4] = X4  dpi
#d[,5] = X5  ddpi



plot(d) # Mostramos el gráfico bidimensional
# Podemos observar que por ejemplo la pop15 y pop75b estan negativamente correlacionados
# porque cuanta mas poblacion joven haya menos poblacion mayor hay y viceversa
# Tambien podemos ver que se diferencian dos grupos en la primera grafica de sr


cov(d) # Matriz de covarianza
cor(d) # Matriz de correlaciones
M<-cor(d) # Guardamos la matriz de correlaciones en la variable M


boxplot(d) # Observa que la variable 4, la dpi es la que tiene mayor varianza,
# la que tiene datos más dispares entre los países
# El resto de variables tambien tiene su correspondiente caja de bigotes
# Por ejemplo la variables 5 tiene 2 VALORES ATIPICOS que se representan por circulitos
boxplot(d[,4])


which.max(d[,5]) # Indica el número del pais con mayor ddpi: numero 49
d[49,] # Mostrando la fila numero 49 descubrimos que el país con mayor ddpi es: LIBIA

sort(d[,5]) # Ordena los VALORES de los ddpi de los países

order(d[,5]) # Ordena LOS PAISES de menor a mayor según sus ddpi

hist(d$sr) # Muestra el histograma. SIRVE PARA CALCULAR SIMETRÍA Y NORMALIDAD
# En el eje x se representa del 0 al 25 la cantidad de sr
# Del 0 al 5: 10 paises tienen de 0 a 5 sr
# Del 5 al 10: 12 países tiene de 5 a 10 sr 
# Del 10 al 15: 25 países tienen de 15 a 25 sr

#Como no es simétrico respecto a la banda de 10 a 15 
# es porque no sigue exactamente una distribucion normal



# Las distancias de Mahalanobis de cada uno de los países a la media
# proporciona la distancia al cuadrado

# PARA DETECTAR VALORES ATIPICOS!!! En este caso UNITED STATES(15.46) y LIBIA(25.66) 
# son los países MAS RAROS

k<-mahalanobis(d,colMeans(d),cov(d))
sort(k) # Los ordenamos de menor a mayor para detectar MAS RÁPIDAMENTE los paises 
        # más atipicos// más raros: Fijándonos en los ultimos valores (USA y LIBIA) 
        # son los países más alejados a la media, SON LOS MAS RAROS




#---------- CALCULO COMPONENTES PRINCIPALES ------------


# Se usa: 
# La matriz de covarianzas cuando todas las variables tienen las mismas unidades
# y los valores de los datos no son muy dispares. 
# En este caso queremos mantener la escala y las variables que varían
# poco tienen poca importancia

# La matriz de correlaciones cuando los datos están puestos en distintas unidades y
# la varianza es muy grande, es decir, los datos son muy dispares
# En este caso las variables originales se estandarizan ¡PONER EL ASTERISCO! y todas tienen 
# a priori la misma importancia (varianza uno).

# Para nuestro conjunto de datos usamos la matriz de correlaciones ya que las escalas
# son muy diferentes

# Hacemos un PCA con princomp usando la matriz de correlaciones de los datos guardados en d 
PCA<-princomp(d,cor=TRUE)
# Usando la matriz de covarianzas seria 
#  PCA<-princomp(d) #ESTO SIEMPRE ESTARIA MAL!!!

summary(PCA,loadings=TRUE) # mostramos las componentes principales

# La importancia de las componentes se mide con sus desviaciones estándar, que corresponde 
# a la primera fila de Importance of components. Cuanto mayor sea mejor

# En cuanto a las otras dos filas de esta matriz, estos valores nos indican que
# la primera componente mantiene un 56.44156 % de la información inicial, 
# la segunda un 25.12133 % y las dos juntas un 81.56289 %, etc.

# Las cargas (loadings) son los vectores propios unitarios de los valores propios anteriores
PCA$loadings->T

# El primer vector propio se utiliza para calcular la primera componente principal:
# Y1 = 0.308 X1* ??? 0.571 X2* + 0.560 X3* + 0.514 X4*4 + 0.0379 X5*

# Siendo Xi* la variable i-ésima estandarizada X???i =(Xi ??? mean(Xi))/sd(Xi)

# Las puntuaciones (scores), es decir, los valores que obtendrían los países 
# en las componentes principales Yi, se pueden calcular mediante:
PCA$scores->S

S[,1] # Esto mostraria el Y1 = 0.308 X1* ??? 0.571 X2* + 0.560 X3* + 0.514 X4*4 + 0.0379 X5*
      # con Xi* estandarizado/normalizado de cada variable X1, X2, X3, X4, X5
      # de cada país.
      # eg: Y1_Australia = 0.308 · 11.43* ??? 0.571 · 29.35 + 0.560 · 2.87* + 
      #                    0.514 · 2329.68* + 0.0379 · 2.87*


# Comprobamos que los valores obtenidos de las componentes principales son correctos

# Valores y vectores propios // Standard deviation y loadings

eigen(M) # Si los comparas con los obtenidos en summary(PCA),
          # la fila de standard deviation, son las raices cuadradas de los $values
          # las columnas de la matriz de los loadings, son los $vectors


# Puntuaciones // Scores 
z<-scale(d)  # Estandarizamos los datos iniciales

y1<-0.30846174*z[,1] - 0.57065322*z[,2] + 0.56043119*z[,3] + 0.51350640*z[,4] + 0.03787232*z[,5]
# Y = T^t · X   :  vectores 5x1
# donde z[,i] es la columna i-esima de la tabla z (i=1,2,3,4,5)

y1 # Para Australia obtenemos 1.35156808
 
S[,1] # Para Australia obtenemos 1.36528994

# No sale el mismo resultado porque princomp usa varianzas y no cuasivarianzas para estandarizar.
# (pag 3 practicas)


# INCISO:

# En el caso en que dispongamos unicamente de la matriz de correlaciones (o covarianza),
# podemos calcular las componentes principales haciendo:
PCA1<-princomp(covmat=M)

# Calculamos las cargas o loadings:
PCA1$loadings->T1
T1
PCA$loadings

# No podemos calcular los scores o puntuaciones, por tanto
# no podremos hacer el gráfico de puntuaciones en las componentes principales
PCA1$scores->S1
S1 #NULL




# Calculo de las componentes principales usando la matriz de correlaciones : prcomp
PCAbis<-prcomp(d,scale=TRUE)


summary(PCAbis)
# caRGAS //LOADINGS // VECTORES PROPIOS
PCAbis$rotation

# PUNTUACIONES // VALORES DE LAS COMPONENTES PRINCIPALES
PCAbis$x

# FIN DEL INCISO



#--------- ANALISIS DE COMPONENTES PRINCIPALES --------

# 1º.- Importancia de las variables sobre las componentes iniciales
# 2º.- Interpretacion de las componentes
# 3º.- Interpretar como sera el individuo en funcion de su valor en Y1

#---------- Analisis de Y1---------

summary(PCA)
# Variable que mas influye? pop15
# Que es Y1? indica a los paises que tienen poblaciones envejecidas y ricos

# Analisis de las puntuaciones de Y1, es decir su valor.
# Esto sirve para decir cómo serán (aproximadamente) los países
#  según los valores que toman en Y1 

# Recuerda que los valores que toman las Yi se calculaban con SCORES
# Analizamos unicamente la fila 1 que corresponde a Y1
summary(S[,1])

plot(S[,1])
# Interpretacion
# Se observan claramente dos grupos, uno inferior y otro superior: Tercer y primer mundo
# La media de S1 es 0, por estar las Xi estandarizadas

which.max(S[,1]) # mayor valor de Y1, Pais con mayor poblacion de mayores y mas rico
which.min(S[,1]) # menor valor de Y1, Pais con mayor poblacion joven y mas pobre

order(S[,1]) #el pais mas rico sera el ultimo, el pais mas pobre sera el primero

S[9,]  #identificamos que paises son
S[28,] 

#compruebo en la grafica, los marcamos en la grafica
text(9+3.5, S[9,1],labels='Florida') #primero coordenada X, segundo cooordenada Y
text(28+3.7, S[28,1],labels='Nevada')


# si te preguntan como es el pais 38, por ejemplo, tienes que hacer
S[38,1] #si te sale un  valor muy grande es pq esta por encima de la media, luego es rico y viejo


#--------Analisis de Y2--------

eigen(M)
# Y2 = 0.5542456 X1* + 0.0126733 X2* - 0.1009938 X3* - 0.2663021 X4* + 0.7820068 X5*
# Y2 representaria los paises mas ricos debido al incremento de los ahorros
summary(S[,2])

plot(S[,2])
which.max(S[,2])



#------ Representar puntuaciones estandarizadas de las comp. Y1 e Y2 ---------

# Como las componentes son incorreladas, las podemos estudiar por separado.
# Pero a veces resulta conveniente estudiarlas por parejas:
# Para representar las cargas y las puntuaciones estandarizadas de las dos primeras 
# componentes haremos
biplot(PCA,pc.biplot=TRUE)

# Los 5 vectores en rojo, son los loadings o cargas, que eran los coefs de la C.L. 
#   de Y1,Y2 en funcion de las  variables

# Las variables con vectores largos (norma cercana a 1) estarán bien representadas
# por las dos primeras componentes, mientras que las que tengan vectores cortos
# estarán mal representadas (se pierden al proyectar por ser casi perpendiculares).

# ¿como influyen las variables sobre las componentes desde el grafico?

# Los angulos que se forman entre los vectores son las correlaciones

# Los nombres en negro son los scores o puntuaciones

sort(d[,1])

order(d[,1])

d[23,]
d[46,]
d[28,]

# Hacemos el grafico pero mostrando el número de cada país, en vez de su nombre
biplot(PCA,pc.biplot=TRUE,xlabs=1:50)

# Representamos 3 y 4 componentes
biplot(PCA,pc.biplot=TRUE,choices=c(3,4),xlabs=1:50)

# Grafico con solo puntuaciones
plot(S[,1],S[,2],xlab='Y1',ylab='Y2')

# ¿COMO ENCONTRAR UN PAIS?: basta con mirar sus puntuaciones // SCORES // valor de las 
# componentes principales

# Ponemos la etiqueta españa al lado, al individuo i=38
d[38,]
text(S[38,1]+0.4,S[38,2],labels='Esp')  #ASI LO PODEMOS LOCALIZAR RAPIDAMENTE
S[38,1]
S[38,2]

# Para poner una etiqueta a todos los paises, debajo
text(S[,1],S[,2]-0.2,labels=row.names(d),cex=0.6) 

# Representar las 3 primeras componentes en grafico 2D:
pairs(PCA$scores[,1:3])



#-------------- SATURACIONES ---------------

# La matriz de saturaciones se usa para saber que variables esta mejor representada
# por las componentes principales

# Para calcularla multiplicamos las cargas por la raiz cuadrada del valor propio//desviacion estandar 
# SATURACIONES DE LA PRIMERA COMPONENTE PRINCIPAL
summary(PCA)
S1<-T[,1]*1.6799041   #multiplico el primer autovector por su desviacion estandar
S2<-T[,2]*1.1207437   #multiplico el segundo autovector por su desviacion estandar
# Las saturaciones al cuadrado nos indicarán cuanta información (en tanto por 1) tendrá
# cada componente PRINCIPAL de cada variable ORIGINAL
S1^2
S2^2
# variable mejor representada por Y1 es pop15 con 0.918995802%, 
# Sin embargo Y1 apenas tiene info de ddpi,  0.04047742 

# ANALOGAMENTE
# MATRIZ DE SATURACIONES
SAT<-cor(d,S)
SAT

# INFO QUE TIENEN LAS 2 PRIMERAS COMPONENTES SOBRE CADA VARIABLE
SAT[,1]^2+ SAT[,2]^2 #COMUNALIDAD, info total que tienen Y1, Y2 sobre las 5 variables
                     # Es equivalente a la fila Cumulative Proportion de summary(PCA)

# Variable mejor representada en las dos primeras componentes (gráfico biplot) 
# es pop15 con un 91.91976 % de info

# Peor representada es sr con un 65.43657 %

# INFO QUE TIENEN EN GENERAL LAS Yi DE LAS VARIABLES
mean(SAT[,1]^2+ SAT[,2]^2) #Es casi la misma media que la obtenida en Cumulative Proportion
summary(PCA)

# La suma de los elementos en la primera columna de la matriz de saturaciones al cuadrado 
# da el valor propio de la matriz de correlaciones
sum(SAT[,1]^2) # o bien sum(S1^2)
eigen(M)

# La MEJOR COMBINACION LINEAL de las dos primeras componentes para estimar (linealmente)
# sr es la que se obtiene multiplicando Coordenada 1 de v1 * Y1 + Coordenada 1 de v2 * Y2
Z1 <- 0.3084617*S[,1] + 0.5542456*S[,2] # MATRIZ NX1, d[,1] MATRIZ 1XN
cor(d[,1],Z1)^2                       

# coincide con la información que mantienen esas dos componentes sobre sr
SAT[,1]^2+ SAT[,2]^2 


# NUMERO DE COMPONENTES

# Fijar un porcentaje mínimo de información mantenida. 
# Si queremos mantener mas de un 90% de info, observamos la linea cumulative proportion
summary(PCA)
#observamos que debemos tomar m=3 y mantendriamos un 93%

# Regla de Rao. 
# solo serán relevantes las componentes que tengan varianza o valor propio mayor que la
# variabilidad mínima de las variables originales.
# Como calculamos las componentes usando la matriz de correlaciones, todas tienen var 1
#por lo tanto, se toman solo las componentes con valores propios
# (varianzas o desviaciones típicas) mayores que uno.
eigen(M)


# Regla de Kaiser. 
# Analogo al anterior si usamos la matriz de correlaciones


# Regla del codo
screeplot(PCA) #grafico histograma
plot(eigen(cor(d))$values,type='l',ylab='valores propios') #grafico linea
# Si ponemos el codo en la componente 3, tomamos las componentes 1 y 2



# Test de esfericidad 
eigen(cor(d))$values->L
mean(L[5:5])->ma #media aritmatica
exp(mean(log(L[5:5])))->mg #media geometrica
(50-(4*5+11)/6)*(5-4)*log(ma/mg)->T
0.5*(5-4-1)*(5-4+2)->gl
1-pchisq(T,gl)

# para m=5 hay esfericidad, es decir, es conveniente eliminar la Y5



# PREGUNTAS EXAMEN
# HACER BIPLOT POR GRUPOS POR SI CAYERA (spoiler: va a caer)

# pais mas raro es el que este mas lejos de la media
# el menos raro es el que esta mas cerca de la media

# quienes fueron los que mas ahorraron? y los que menos?
# Esto debes de poder conseguirlo con el grafico 3D

# No va a entrar en el examen el ejercicio con datos muy raros (EJERCICIO 2)

# LA Y2 es siempre menos importante

# printcomp y  usar tambien biplot

# el ASTERISCO es muy importante ponerlo, significa que están normalizadas


# La Y1 representa que hay mucha integridad judicial
# Y2 lo contrario

# El plot de nombres te va a dar error. tienes que seleccionar solo las columnas que quieres pintar
# plot( d, 5,10) POR EJEMPLO

# Y1 siempre es la más importante. 
# COMO es el OSO 135? OSO pequeño o debajo de la media en cuanto a tamaño y cabezon

# scores son los ejes x e y scores estandarizados
# loading son los ejes opuestos
# s(27)

# Localizar al individuo 27 y decir como es, PARA ESO TENEMOS LOS SCORES
# SCORES sin estandarizar, 
# biplot si estandarizados