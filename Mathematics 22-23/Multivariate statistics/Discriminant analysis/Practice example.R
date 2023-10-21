# Practica 2. Segunda parte de la asignatura Estadistica Multivariante.


# Cómo clasificar individuos entre diversos grupos a partir de sus MEDIDAS 
# (numéricas) en algunas variables. 

#Para ello necesitaremos disponer de una muestra de las variables en estudio 
# en individuos de cada grupo (al menos DOS individuos por cada grupo)


#-------Análisis inicial de los datos--------

# Estudiamos las diferencias de las VARIABLES en cada uno de los grupos
# para determinar si serán de utilidad a la hora de clasificar a los 
# individuos de los distintos grupos

# Para archivos .rda
load('C:/Users/loreshu/Desktop/Mathematics-2019/University-mathematics-projects/Mathematics 22-23/Multivariate statistics/Discriminant analysis/Data/escarabajos.rda')

# Para archivos .R
# Primero abro el fichero .R que me he descargado directamente del AV
# Lo ejecuto (run)
# Se guarda automaticamente en Data (a la derecha) la variable wine
#View(wine) # observo lo datos, ya puedo interacturar con ellos!!!


View(d)
# Comprobamos que dicho fichero contiene una muestra de 40 escarabajos de
# dos especies diferentes (Haltica Oleracea HO y Haltica Carduorum HC)


# d[, 1] = X1 = distancia desde el tórax al surco transversal
# d[, 2] = X2 = longitud escarabajo (micras)
# d[, 3] = X3 = longitud de la base de las antenas secundarias (mm)
# d[, 4] = X4 = longitud de la base de las antenas terciarias (mm)
# d[, 5] = X5 = Nombre de la especie a la que pertenece (HO, HC)
# d[, 6] = X6 = (HO=1, HC=2)

# Del escarabajo 40 se desconoce la especie (NA not available)


# La primera fila que aparece es el valor de surco del escarabajo 40
# El resto de filas calcula la media, cuartiles y valores extremos de las dos especies HC y HO
tapply(d$surco,d$especie,summary)

# CONCLUSIÓN
# Media de la variable surco en HO 194.5 > 179.6 Media de la variable surco en HC

plot(d$surco,d$codigo)

# Escarabajo 40 esta en:
text(d$surco[40],1.5,labels='e40')

# Este gráfico no discrimina (separa) bien a los grupos
# Si tuvieramos que meter al escarabajo 40 en algun grupo lo meteriamos 
# en el grupo 2 (HC) pq se acerca mas a su media

# *=1, HC=2 y HO=3
plot(d$surco,d$especie)

# Estudiamos el resto de variables
plot(d$long,d$codigo) # No separa bien
text(d$long[40],1.5,labels='e40') # No se donde clasificaria al escarabajo 40 con el 
                                  # grafico, pero su media se acerca mas a la de H0
tapply(d$long,d$especie,summary)

plot(d$base2,d$codigo) # Tampoco separa bien
text(d$base2[40],1.5,labels='e40') # Lo clasificaria en grupo 1 (HO) POR SU MEDIA
tapply(d$base2,d$especie,summary) # su media se acerca mas a la de HO

# ESTA ES LA QUE MEJOR DISCRIMINA
plot(d$base3,d$codigo)# Separa bastante bien los grupos aunque hay algunos que se mezclan
text(d$base3[40],1.5,labels='e40') #Lo clasificaria en el grupo 1 (H0) POR SU MEDIA
tapply(d$base3,d$especie,summary) # su media se acerca mas a la de HO


boxplot(d$surco ~ d$especie) # alt gr + 4 para conseguir la ondita esa ~
# Probabilidad entre 50% y 75% de que e40 pertenezca a la especie HC
# Probabilidad de que la especie pertenezca a HO

# Notamos que el 75% de los individuos se clasifican bien....


# Observamos que el escarabajo 40
# estaría en la caja de la especie HC (por poco) pero que no sería un valor
# atípico en la HO


boxplot(d$long ~ d$especie)
# Si e40 perteneciese a HC, como el 1er cuartil esta por encima de la raya negra de e40, 
# esto significaria que e40 estaria entre el 25%  de los individuos de HC
# (Probabilidad menor que 25% de que e40 pertenezca a HC)

# La caja significa que el 75% de los individuos de HO se situan por debajo del lado superior de la caja.
# Como el 3 cuartil esta por encima de la raya negra de e40, 
# entonces e40 estaria entre el 75% de los individuos de HO.

#??????DUDA: ¿Lo siguiente esta bien???
# Probabilidad entre 75% y 50% de que e40 pertenezca a la especie HO

# P(HC|*)=P(*|HC)*P(HC)/P(*)
# P(HO|*)=P(*|HO)*P(HO)/P(*)

boxplot(d$base2 ~ d$especie)
# Probabilidad menor que 25% de que la especie pertenezca a HC
# Probabilidad entre 50% y 75% de que e40 pertenezca a la especie HO

boxplot(d$base3 ~ d$especie)
# Probabilidad menor que 25% de que la especie pertenezca a HC
# Probabilidad entre 50% y 75% de que e40 pertenezca a la especie HO


# Estudiamos las variables por parejas
plot(d$surco,d$long,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)
# Podemos observar que por debajo de la bisectriz se quedan los individuos de HO, y por encima los HC
# Siendo la bisectriz la linea que une los puntos (160, 240) y (220, 320)

# En este caso, la grafica discrimina bien los grupos// Los grupos estan bastante separados
# Pero e40 queda en medio //estaria entre ambos grupos,  por lo tanto no es facil clasificarlo


#plot(d$surco, d$long)
#text(d$surco,d$long,d$especie,cex=0.7,pos=4,col='red')


# Estudiamos el resto de variables por parejas
plot(d$long,d$base2,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)

plot(d$base2,d$base3,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)

plot(d$surco,d$base3,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)

plot(d$surco,d$base2,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)

plot(d$base2,d$base3,pch=as.integer(d$especie))
legend('bottomright',legend=c('e40','HC','HO'),pch=1:3)
# Conclusion: Ningun par de variables es capaz de clasificar bien el escarabajo 40
#Ninguno separa los grupos suficientemente bien



# Clasificacion usando grafico PCA

# Este contendrá informacion de todas las variables
pca<-princomp(d[,1:4],cor=TRUE) # calculo de componentes principales
summary(pca,loadings=TRUE)
# M<-cor(d)
# eigen(M)
biplot(pca,pc.biplot=TRUE,xlabs=d$especie)
# En el grafico se separan bastante bien las especies.
# las dos primeras componentes principales no siempre son las mejores variables para clasificar



#---------Análisis Discriminante Lineal (LDA)--------

library('MASS')

#2.1.-Linear Discriminant Analysis
LDA<-lda(d[1:39,1:4],d[1:39,6],prior=c(0.5,0.5))
LDA
# IMPORTANTE QUE LAS PROBABILIDADES A PRIORI SUMEN 1!!!!!!!
# Si hay 3 grupos, en vez de poner 0.33 que no funcionaria, tienes que poner 1/3


# Alternativas para coger filas y columnas especificas de la matriz d

# Usando union()
#LDA<-lda(d[1:39,union(1:2,4)],d[1:39,6],prior=c(0.5,0.5))

#Señalando las columnas manualmente
#LDA<-lda(d[1:39,c(1,2,4)],d[1:39,6],prior=c(0.5,0.5))


# Coeficientes estimados de la FDL (Funcion de analisis discriminante)
a<-LDA$scaling

a

# Calculamos la funcion discriminante, es decir, la proyeccion del e40:
# L(Z) = a'Z, con Z las medidas de e40 y a los scaling
L<-function(z) sum(a*z)
# Y proyecciones de las medias de los grupos L(X) y L(Y)

mHO<- L(LDA$means[1,])
mHC<- L(LDA$means[2,])
K<-(mHC+mHO)/2

# Clasificamos el e40 en el grupo que tenga su proyeccion de la media mas cercana a la L(Z)
# Si me < K => e en HO;  me > K => e en HC
# Calculamos la proyecciones de TODOS los escarabajos

# Vamos calculando las proyecciones de las filas en d
# y las guardamos en D que es una matriz columna de tamaño 40, con las proyecciones de cada escarabajo
D<-1:40 # vector columna
for (i in 1:40) D[i]<-L(d[i,1:4]) # guardamos cada proyeccion de los escarabajos
D[1]
D[40] # = 3.968782 < K, nos conduciría a clasificarlo como del grupo HO

plot(D,d$codigo,ylim=c(1,2.1))

text(D,d$codigo,cex=0.7,pos=1,col='red') # este comando solo numera los escarabajos:
                                         # del 1-19 en HO , del 20-39 en HC

# Incluyo la puntuación del escarabajo 40 y la constante K 
text(D[40],1.5,labels='*')                            # ponemos un * en el escarabajo 40
text(D[40],1.5,labels='e40',cex=0.7, pos=3,col='red') # imprimimos el escarabajo 40
abline(v=K)                                           # linea vertical x= k 
text(K+0.1,1.5,labels='K',cex=0.7,pos=3,col='red')    # pintamos K al lado de la linea vertical
# El escarabajo 27 está mal clasificado segun este criterio

# Si hacemos D - K, la regla de decisión dependerá de si las puntuaciones son positivas o negativas:
# Si es negativa pertenece a HO, si es positiva pertenece a HC.



# 2.2.- Funcion predict()

# Con esta funcion predict, conseguimos de manera automatica el D-K
# sin necesidad de calcular ni D ni K
predict(LDA,d[,1:4])->P 
P # en efecto los primeros 19 escarabajos son negativos, y el resto menos el 27 positivos
# P coincide con D-K
D-K


plot(D-K,d$codigo,ylim=c(1,2.1))
text(D[40]-K,1.5,labels='*')                            # ponemos un * en el escarabajo 40
text(D[40]-K,1.5,labels='e40',cex=0.7, pos=3,col='red') # imprimimos el escarabajo 40
abline(v=0)                                           # linea vertical x= k 
text(0.1,1.5,labels='K',cex=0.7,pos=3,col='red')    # pintamos K al lado de la linea vertical

#Histograma de los datos D-K, siendo D la columna de proyecciones de los escarabajos
ldahist(P$x,g=d$especie)

# Vemos en qué grupo se clasifican los 40 escarabajos. Grupo 1 = HO, Grupo 2 = HC
# Esta funcion sigue el criterio de si la proyeccion del escarabajo i es < o > que K
P$class

# Podemos ver si la clasificación es correcta para los 39 escarabajos con grupo conocido
P$class==d[,6]->Resumen
Resumen #Todos TRUE menos el 27


table(P$class,d[,6]) # Los que aparecen en la diagonal es el numero de aciertos:
                     # Escarabajos del grupo 1 (HO) que estan clasificados como HO 19
                     # Escarabajos del grupo 2 (HC) que estan clasificados como HC 19
                     # Hay 1 escarabajo del grupo 1 que lo han clasificado en el grupo 2
                     # Hay 0 escarabajos del grupo 2 que lo han clasificado en el grupo 1 

P$posterior

# Observamos que las probabilidades a posteriori del escarabajo 40 son:
# P(HO | z=e40) = 0. 753157
# P(HC | z=e40) = 0. 246842
# Nos indica que la clasificacion no es muy fiable para un individuo con esas medidas

# Para clasificar a un escarabajo con medidas z =(185, 280, 150, 200)
z<-c(185,280,150,200) # c significa que quiero que me haga una matriz columna
predict(LDA,z)
# class: el grupo en que lo meteria 1 o 2
# posterior : probabilidades a posteriori. P(HO | z) = 0.1872666;  P(HC | z) = 0.8127334
# x seria su puntuacion = 0.3965766, es decir, la diferencia D-K, siendo D su proyeccion
# Observamos que x coincide con L(z) - K
L(z)-K # = 0.3965766

# Usando la tabla, podemos estimar las proporciones de acierto
table(P$class,d[,6])
# Probabilidad de acierto global estimada
38/39 # = 0.974359



# 2.3.-Usando LDA y VALIDACION CRUZADA (cross validation o CV)---------
# Solo afecta a los individuos a los que ya se les ha clasificado en un grupo, no al e40

# LDA<-lda(d[1:39,1:4],d[1:39,6],prior=c(0.5,0.5))
LDACV<-lda(d[1:39,1:4],d[1:39,6],prior=c(0.5,0.5),CV=TRUE) 

# P<-predict(LDA,d[,1:4])
# P$class es el grupo donde lo meten segun el criterio LDA
LDACV$class==d[1:39,6] # Ahora estamos aplicando el criterio validaciones cruzadas, salen different values 

LDACV$posterior # Las probabilidades a posteriori de los individuos con grupos conocidos también cambian

# La validación cruzada no afecta a la clasificación de los individuos de los que se desconoce el grupo.

#table(P$class,d[,6])
table(LDACV$class,d[1:39,6]) # observa que ahora SI especificamos el numero de filas
# Ahora tenemos 19 escarabjos bien clasificados en el grupo 1
# 3 escarabajos del grupo 1 que los ha clasificado en el grupo 2
# Y 17 escarabajos bien clasificados en el grupo 2

# Cuales son los escarabajos que se han clasificado mal?
which(LDACV$class!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)
# 21, 27, 36

# Probabilidad global de acierto en este LDA es:
(19 + 17)/39 # = 0.9230769 < que la anterior


# ¿Qué pasa si cambiamos las probabilidades a priori y encima no las ponemos iguales?
# Las probabilidades a priori es la P(HO)=1/2 y P(HC)=1/2, es decir, la prob de que salga de especie HO O HC
LDA3<-lda(d[1:39,1:4],d[1:39,6],prior=c(0.2,0.8))
predict(LDA3,d[,1:4])->P 
P
P$class[19] #AHORA EL ESCARABAJO 19 ES DEL GRUPO 2!!!!!!!
which(P$class[1:39]!=d[1:39,6], arr.ind = FALSE, useNames = TRUE) # Lo comprobamos

# Si m>2 se necesita una funcion discriminante para cada par de grupos



#-------------Análisis Discriminante Cuadrático--------

# Realizamos un QDA a partir de los datos de los escarabajos
QDA<-qda(d[1:39, 1:4], d[1:39, 6],prior=c(0.5,0.5))

QDA

QDA$scaling   # matrices triangulares Ui tq Ui'Ui=Si^(-1) siendo Si la de varianzas 
QDA$ldet      # log |S1|=19.41635 y log |S2|= 19.56726

# Funciones discriminantes cuadráticas
# final pag 5, esto es teoria

# Para obtener las predicciones basadas en estas funciones o, equivalentemente,
# en las probabilidades a posteriori, (P(e40 | HO ), (P(e40 | HC ) podemos hacer:
predict(QDA,d[,1:4])->P
P
P$class #solo hay un escarabajo mal clasificado
which(P$class!=d[1:40,6], arr.ind = FALSE, useNames = TRUE) # El 27
# which(P$class[1:39]!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)

P$posterior # P(HO | z=e40) = 0.5.817418 ; P(HC | z=e40) = 0.4.182582 probabilidades de pertenencia, no fiable

table(P$class,d$codigo)

# Para que esta tabla sea más realista debemos usar validación cruzada
QDACV<-qda(d[1:39,1:4],d[1:39,6],prior=c(0.5,0.5),CV=TRUE)
table(QDACV$class,d[1:39,6])
(17 +18)/39 #= 0.8974359 estimacion de probabilidad global de acierto 


#predict para clasificar nuevos individuos
#Supongamos que queremos clasificar al individuo z
z<-c(185,280,150,200)
predict(QDA,z) # Lo clasifica en el grupo 2
# Probabilidad a posteriori de pertenencia al grupo 2 de 
# P(HC | e40 )=0.9636754
#Esta clasificacion si es fiable bajo hipotesis de normalidad 



# 4.- Comprobaciones del modelo.

# LDA si matrices de covarianzas teóricas son iguales 
# QDA si los datos son normales en cada grupo

# El método de validación cruzada nos proporciona estimaciones de las probabilidades de acierto 
# en cada caso

#También tenemos la opción de usar ambas técnicas y comprobar si los resultados coinciden

#Calculamos matriz de cuasicovarianzas del primer grupo

S1<-cov(d[1:19,1:4]) #matriz covarianzas del 1er grupo

# Separamos las 4 primeras variables del grupo 1
d1<-d[d$especie=='HO',1:4] 

cov(d1) # Matriz cuasicovarianzas

S2<-cov(d[20:39, 1:4])
d2<-d[d$especie=='HC', 1:4]
cov(d2)


# las matrices de covarianzas de los grupos son bastante diferentes
# (no parecen estimaciones de una misma matriz)
# por tanto aparentemente sera mejor QDA
 
# comprobamos que los a, los coeficientes del LDA, son correctas
# calcular la estimación de la matriz de covarianzas común V
S<-(18*S1+19*S2)/37 #S=(1/n+m-2)[(n-1) S1 + (m-1 S2)]
S
solve(S)->In #matriz inversa de S

#medias de los grupos
LDA$means[1,]->m1
LDA$means[2,]->m2
m1 #media en cada variable del grupo 1
#equiv
colMeans(d1)

m2 #media en cada variable del grupo 2

(m1-m2) %*%In->a #coeficientes a

a

#Comprobamos que son proporcionales a a calculado con scaling, con R
LDA$scaling/t(a) #t(a) es el traspuesto de a
#de aqui lambda=-0.2701715 

#¿Que variables influyen mas en los procedimientos de clasificacion LDA?
# Al contrario que con PCA 
# los procedimientos de clasificación LDA y QDA dan el mismo resultado
# si se usan las variables estandarizadas

ds<-scale(d[,1:4]) #estandarizamos datos
LDA4<-lda(ds[1:39,1:4],d[1:39,6],prior=c(0.5,0.5))
LDA4$scaling
#Lavariable que mas influye//mejor discrimina es surco
#la que menos base2

# ¿Podemos eliminar alguna variable???
# usamos validacion cruzada
LDA5<-lda(d[1:39,2:4],d[1:39,6],prior=c(0.5,0.5),CV=TRUE) #eliminamos surco
LDA5$class==d[1:39,6]
which(LDA5$class!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)
# 7 Escarabajos mal

# Haciendo esto con el resto deducimos
# mejores opciones son eliminar long o base2 (en ambos casos solo
# hay 2 escarabajos que se clasifiquen mal)

LDA5<-lda(d[1:39,union(1,3:4)],d[1:39,6],prior=c(0.5,0.5),CV=TRUE) #eliminamos long
LDA5$class==d[1:39,6]
which(LDA5$class!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)#solo 2 mal

LDA5<-lda(d[1:39,1:2,4],d[1:39,6],prior=c(0.5,0.5),CV=TRUE) #eliminamos base2
LDA5$class==d[1:39,6]
which(LDA5$class!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)# 3 mal

LDA5<-lda(d[1:39,1:3],d[1:39,6],prior=c(0.5,0.5),CV=TRUE) #eliminamos base2
LDA5$class==d[1:39,6]
which(LDA5$class!=d[1:39,6], arr.ind = FALSE, useNames = TRUE)# 3 mal

#probabilidades a posteriori 
library(mvtnorm)
dmvnorm(d[40,1:4],m1,S)->f1
dmvnorm(d[40,1:4],m2,S)->f2

#Si las probs a priori son iguales
f1/(f1+f2)
# Pr(1|z = e40) = 0.7531572

# si las probs a priori vienen dadas por los grupos
19*f1/(19*f1+20*f2)
# Pr(1|e40) = 0.743497


# Compruebe usando un procedimiento análogo (pero sustituyendo S por S1 y S2) 
# las probabilidades a posteriori calculadas en el QDA.

library(mvnormtest)

mshapiro.test(t(d[1:19,1:4])) #p-valor>0.05 primer grupo sigue dist normal

mshapiro.test(t(d[20:39,1:4])) # 0.05769>0.05 segundo grupo sigue dist normal por poco

#plot(d[20:39,1:4])

# Si hay mas de dos grupos, se calculan las funciones discriminantes lineales por grupos
# z'S^-1mi - 1/2 * mi'S^-1mi
solve(S) %*%m1
solve(S) %*%m2
-0.5*t(m1) %*%solve(S) %*%m1
-0.5*t(m2) %*%solve(S) %*%m2

# Obtenemos L1(z) = 0.95572173 z1 - 0.02086224 z2 + 0.68425036 z3 + 0.43531246 z4 -177.6155
#           L2(z) = 0.6104728 z1 + 0.1095255 z2 + 0.7906842 z3 + 0.5786658 z4 ??? 193.4209
# Funciones discriminates de los grupos, 
# Para e40 nos quedamos con L1 por ser mas grande

# Los individuos z se clasificarán en el grupo con valor máximo de estas funciones.
# Este método es equivalente al de máxima verosimilitud
# Con matrices de covarianzas iguales
# por lo que se obtendrán los mismos resultados que en la sección 2
# Es equivalente a usar las funciones discriminantes de Fisher paso a paso

#Para QDA,
# (z ??? X)'S_1^???1(z - X) + log | S1 |
solve(S1)->S11 # MATRIZ INVERSA DE S1
solve(S2)->S22 # MATRIZ INVERSA DE S2
QDA$ldet  # log |S1|=19.41635 y log |S2|= 19.56726

# Medias de los grupos
LDA$means[1,]->m1
LDA$means[2,]->m2

# Dado z el comando seria
#t(z-m1) %*% S11%*% (z-m1) + QDA$ldet[1]
z = c(182.22, 271.01, 140.99,190.15)
t(z-m1) %*% S11%*% (z-m1) + QDA$ldet[1] # = 22.76788 funcion cuadratica 1
t(z-m2) %*% S22%*% (z-m2) + QDA$ldet[2] # = 23.42774 funcion cuadratica 2

#Nos quedamos con el grupo 1 HO porque es menor
#con matrices de covarianzas distintas


#-------- Distancia de mahalanobis QDA-------

# D1(z) = (z ??? X)'S_1^1(z ???  X)
t(z-m1)%*%S11%*%(z-m1)

#D2
t(z-m2)%*%S22%*%(z-m2)

#-------- Distancia de mahalanobis LDA -------

# D1(z) = (z ??? X)'S_1^1(z ???  X)
t(z-m1)%*%solve(S)%*%(z-m1)

#D2
t(z-m2)%*%solve(S)%*%(z-m2)

# list<-split(d, d$surco)
# list2env(list, .Data)

# Como poder usar el archivo wine.R
# 1er paso: Session -> Set Working Directory -> Choose Directory. y seleccionas el directorio Practicas2
# 2o paso: Puedes hacer 2 cosas
# OPCION A:
# Me descargo el archivo de internet
wine<-read.table('http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data',sep=',')
# Guardo la variables wine en el fichero wine2.R
dump('wine','wine2.R')
#Leo el fichero wine2 que de momento solo tiene un archivo que se llama wine
source('wine2.R')

View(wine)

#OPCION B
# Primero abro el fichero .R que me he descargado directamente del AV
# Lo ejecuto (run)
# Se guarda automaticamente en Data (a la derecha) la variable wine
View(wine) # observo lo datos, ya puedo interacturar con ellos!!!

