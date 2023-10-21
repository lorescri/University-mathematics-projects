# Ejercicios practica 1. Segunda parte de la asignatura Estadistica Multivariante.

# EJERCICIO 1 
#   Aplicar un PCA a los datos del fichero: USArrests que contiene datos sobre los 
#   arrestos por cada 100.000 residentes por asesinato, asalto o violacion en cada uno de
#   los 50 estados de USA en 1973. Tambien se incluye el porcentaje de poblacion que vive
#   en las areas urbanas. Fuente: help(USArrests)


#--------------- ESTUDIO INICIAL DE LOS DATOS -----------------

data()
help(USArrests)
d<-USArrests
View(d)
help("USArrests")
 #      d[,1]: MURDER    numero de arrestos por asesinato (por cada 100000 residentes) 
 #      d[,2]: ASSAULT   numero de arrestos por asalto (por cada 100000 residentes) 
 #      d[,3]: URBANPOP  numero de de porcentaje de poblacion urbana 
 #      d[,4]: RAPE      numero de arrestos por violacion (por cada 100000 residentes) 

summary(d)
str(d) # Este comando indica las variables que hay y de que tipo son.
plot(d)# Se observa como entre murder y assault hay una correlacion positiva,
       # de la misma manera que entre assault y rape.
       # En el resto de graficos, la nube de puntos es amorfa y no sugiere ninguna
       # recta de regresion.

cov(d)  # Matriz de covarianza.
cor(d)  # Matriz de correlaciones.

boxplot(d)      
# Observamos que la variable con mayor varianza es assault.
# Mientras mayor sea la varianza, mayor será la dispersión de los datos,
# y por tanto mas informacion aporta.

boxplot(d[,1]) 
boxplot(d[,2])
boxplot(d[,3])
boxplot(d[,4]) 
# En este ultimo grafico encontramos dos posibles valores atípicos 
# que se salen de la normalidad, respecto a la variable RAPE.


which.max(d[,4])
sort(d[,4])
order(d[,4]) 

d[28,] # NEVADA es el estado de USA con mayor nº de arrestos por violacion (por cada 100000 residentes).
d[2,]  # En sgundo lugar esta ALASKA.

# Calculamos la distancia de mahalanobis de cada uno de los estados a la media.
mu<-colMeans(d)

ma<-mahalanobis(d,mu,cov(d)) # Calculamos la distancia con respecto a la media.
#Por lo tanto, el mas raro sera el que este mas distante.
order(ma)

d[2,] #(Alaska)



#---------- Calculo de COMPONENTES PRINCIPALES ------------

cov(d)
# En nuestro conjunto de datos las escalas (varianzas) son muy diferentes (traza),
# y las variables se miden en unidades diferentes.
# Entonces usamos la matriz de correlaciones para calcular las componentes principales,
# que son unicas salvo cambio de signo.

PCA<-princomp(d,cor=TRUE)


#------------- ANALISIS DE COMPONENTES PRINCIPALES ------------

# 1.- Estudiar la importancia de las componentes iniciales.

    summary(PCA,loadings=TRUE)
    T<-PCA$loadings
  
    # La componente principal que mejor mantiene la info de las variables iniciales 
    # es Y1, con un 62%.
    # En segundo lugar Y2 (24.74%), Y3 (8.91%) e Y4 (4,33%).
    # Las dos ultimas no son muy relevantes.
  
    # Y1 e Y2 mantienen el 86.75% de info de las variables iniciales.
  
    
    # Pero puede haber variables que esten mejor representadas en otra componente que en Y1, 
    # fijandonos en los loadings
    T
    # Como t33=0.378 > 0.278=t31, e.d. la variable 3 UrbanPop, influye mas
    # en la componente 3 que en la componente 1.
    
    # Otra forma de ver cuanta info guarda cada componente de las variables
    # es con las saturaciones
    S1<-T[,1]*1.5748783
    S2<-T[,2]*0.9948694
    S1^2 #Y1 guarda solo un 19.19463% de la info de urbanpop.
    S2^2 #Y2 por el contrario guarda el 75.399382% de urbanpop.
    
    # Guardamos las puntuaciones de las comp. principales, sera una matriz nx4.
    PCA$scores->S 
    
    
# 2.- Interpretacion de las componentes principales.
    
#  Las cargas (loandings) son los coeficientes de las componentes 
#  que queremos analizar para poder dar un significado a estas 
#  variables nuevas.

T      
  # Observamos que las variables que mas influyen en Y1 (por orden de influencia) son:
  # Assault(+) >> Rape(+) >> Murder(+) >> UrbanPop(+) 
  # Y1= 0.536 X1* + 0.583 X2* + 0.278 X3* + 0.543 X4*

  # Por el signo positivo, Y1 tomara valores grandes en los estados con valores grandes.
  # Sobre todo en Assault, Rape y Murder.
  # Por los significados de estas variables, que muestran los estados mas peligrosos
  #(con mayor numero de arrestos) 
  # La componente Y1 informa de la peligrosidad de los estados.
  

  # Las variables que mas influyen en Y2 son:
  # Urbanpop(-) >> Murder(+) >> Assault(+) >> Rape(-)
  # Es decir, Y2 tomará valores pequeños en los estados con valores grandes en UrbanPop
  # Podriamos interpretar que Y2 representa estados rurales y con frecuencia de asesinatos.


  # Para Y3 el orden de influencia es rape, urbanpop, murder,assault. 
  # Luego, Y3 va a tener valores grandes cuando el numero de violaciones sea
  # pequeño y el resto grande.
  # Por tanto mide las ciudades con pocas violaciones en poblaciones normal.


  # Para Y4, no hay violaciones, graba la frecuencia de asesinatos y hay escasez de asaltos.
  # El orden es: assault,murder,urbanpop y rape.
  # Por tanto, Y4 sera mayor cuando menos asaltos tengan y muchos asesinatos.
  # Luego, Y4 mide las ciudades con mas asesinatos y menos asaltos.



# 3.- Analizar las puntuaciones de componentes
  # Para estudiar como seran aprox los individuos de la muestra segun los 
  # valores que toman en esa comp.

  # Repito puntuaciones
  S <- PCA$scores 
  
  # Informacion de las puntuaciones de Y1.
  summary(S[,1]) 
  # Los valores de la muestra en Y1 estan entre el min=-2.9922 y el max=3.0130.
  # Obtenemos media 0 pues usamos var. estandarizadas.
  
  # Vemos el grafico de puntuaciones para Y1.
  plot(S[,1]) 
  
  # Como hemos visto antes, Y1 indica como de peligrosos son los estados, 
  # entonces los estados que estan por arriba son los mas peligrosos y 
  # los que estan por debajo son los menos peligrosos.
  
  which.max(S[,1])
  sort(S[,1])  # Ordena los valores de menor a mayor.
  order(S[,1]) # El estado mas peligroso se situa en la posicion 9 (Florida).
               # El segundo estado mas peligroso se situa en la posicion 28 (Nevada).
  
  S[9,1]  # 3.013042
  S[28,1] # 2.874395
  
  # Comprobamos estos datos en la grafica
  text(9+3.5, S[9,1],labels='Florida') # Primero coordenada X, segundo cooordenada Y.
  text(28+3.7, S[28,1],labels='Nevada')
  
  which.min(S[,1]) #El estado menos peligroso es Dakota Del Norte (puesto 34).
  S[34,1]          #-2.992226
  
  text(34+4.6, S[34,1],labels='Dakota N')
  
  
  # Podemos elegir un estado y ver como es en cuanto a peligrosidad.
  # Por ejemplo elegimos Mississippi (24).
  S[24,1] # 0.9964945
  text(24+1.6, S[24,1],labels='Mi')
  # Observamos que esta por encima de la media.
  
  #Podemos hacer lo mismo con el resto de componentes principales.
  
  
  

# Representar cargas y puntuaciones estandarizadas de las componentes Y1 e Y2.

biplot(PCA,pc.biplot = TRUE) # [Interpretacion del grafico en los apuntes].
PCA$loadings # Para el dibujo de los vectores

# vamos a ver cual de los datos de Murder es mayor.
View(d)
which.max(d[,1])
sort(d[,1])
order(d[,1]) # Mayor Murder puesto 10.

d[10,] # Georgia

# Y el segundo con mayor Murder puesto 24, Mississipi
# (en la grafica no se ve tan claro y es normal pues al proyectar las variables originales, 
# se puede perder info contenida en ellas).



# Sustituir los nombres de los paises (etiquetas de los datos) por sus numeros de linea.
biplot(PCA,pc.biplot = TRUE, xlabs=1:50) 
# Hay 50 estados

# Grafico con las componentes Y3 e Y4.
biplot(PCA,pc.biplot = TRUE, choices=c(3,4),xlabs=1:50)

# Grafico de las puntuaciones de las primeras componentes 1 y 2.
plot(S[,1],S[,2], xlab='Y1',ylab='Y2')
# Indiana puesto 38.
S[38,1]
S[38,2] 
# Lo buscamos en el grafico y colocamos i=3.
text(S[38,1],S[38,2],labels = 'Ind')


#-------------- SATURACIONES ---------------

# Como hemos usado la matriz de correlaciones para calcular el PCA.
PCA <- princomp(d,cor=TRUE)
summary(PCA, loadings=TRUE)
T<-PCA$loadings
eigen(cor(d))

# Saturaciones
SAT <- cor(d,S)
SAT


# Informacion

SAT[,1]^2
# La suma de sus elementos me da el valor propio [Var(Y1)=primer valor propio]
# de la matriz de correlaciones aprox., lambda1=2.4802416.

sum(SAT[,1]^2) # = 2.480242 = lambda1  ver [eigen(cor(d))]
eigen(cor(d))

# La media de sus elementos es la proporcion de varianza de Y1 [ver summary(PCA)]
mean(SAT[,1]^2) # = 0.6200604
summary(PCA)
# La variable que mejor representa Y1 es Assault (84.35%). 
# Despues Rape (73.25%), Murder (71.23%), UrbanPop (19.19%).

SAT[,2]^2
sum(SAT[,2]^2) # = 0.9897652 = lambda2
mean(SAT[,2]^2) # = 0.2474413 = proporcion de varianza de Y2
#La variable que mejor representa Y2 es UrbanPop (75.4%) y la peor Rape (2.78%)



# Correlaciones multiples (comunalidades) usando las comp Y1 e Y2.

SAT[,1]^2+SAT[,2]^2 #comunalidades (info mantenida por Y1 e Y2 sobre cada variable)

# La variable mejor representada en las comp. 1 y 2 es UrbanPop,
# que continenen un 94.59401% de su informaacion.
# Y la peor representada es Rape, con un 76.01701.
# Realmente Y1 e Y2 representan bien a todas las variables.


# Media de las comunalidades de Y1 e Y2 = proporcion acumulada de Y1 e Y2 [ver summary(PCA)].
mean(SAT[,1]^2+SAT[,2]^2) # = 0.8675017 (info que mantienen en promedio Y1 e Y2).
summary(PCA)



# La mejor C.L. de Y1 e Y2 para estimar (linealmente) X1:

# Miro T que son los loadings de las variables Y1 e Y2
SAT
T[,1]# = t1 = (t11,t21, ... ,tk1)' (Y1)
T[,2]# = t2 = (t12,t22, ... ,tk2)' (Y2)
# Tomo aquellos correspondientes a la variable X1 (MURDER): t11 = 0.5358995 ,t12 = 0.4181809
#Z1 = t11 * Y1 + t12 * Y2
Z1 <- 0.5358995*S[,1] + 0.4181809*S[,2]

cor(d[,1],Z1)^2 #= cor(X1,Z1)^2 = comunalidad entre Y1 e Y2




# ¿Con cuantas componentes pirncipales debemos quedarnos? 

# 5.1.- Fijar un numero concreto de componentes.

summary(PCA)
# Tomando m=2, analizariamos Y1 e Y2, o sea, mantendriamos p=86.75% (propor. acumulada),
# de la info inicial, lo cual es aceptable al reducir la dim de 5 a 2.

SAT[,1]^2+SAT[,2]^2
# La variable peor representada por Y1 e Y2 es RAPE, de la que mantienen 76.02%, 
# que tambn es buena representacion, entonces todas estan bien representadas.



# 5.2.- Fijar un porcentaje minimo de informacion mantenida.

# Al menos un porcentaje p de variabilidad inicial.
# P.e. p=90%
# Entonces miramos las proporciones acumuladas.
summary(PCA)
# La proporcion acumulada de Y1, Y2 e Y3 es la primera mayor que p, ent. m=3 
# con lo que tendriamos 95.66% de info inicial

# Fijar un porcentaje minimo para las comunalidades.
# P.e. si queremos que las comunalidades sean mayores que 0.5,
# es decir, mantener al menos un 50% de todas las variables
SAT[,1] # No
SAT[,1]^2+SAT[,2]^2 # Si, con m=2


# 5.3 Regla de Rao.

# Una componente sera relevante si su variabilidad es mayor que la variabilidad MINIMA
# de las variables originales.

# Hemos usado la matriz de correlaciones (Variables estandarizadas)
summary(PCA)
# Comp1 es relevante, m=1.



# 5.4 Regla de Kaiser.

# Una componente sera relevante si su variabilidad es mayor que la variabilidad MEDIA 
# de las variables originales.

# Hemos usado la matriz de correlaciones (Variables estandarizadas), la media es 1 y 
# coincide con Rao, m=1.



# 5.5 Regla del codo o del grafico de sedimentacion.

# Representar j frente a las estimaciones de los valores propios (lambda^_j).
# Grafico de sedimentacion.
# seran representativas las comp hasta el 1er codo (sin incluir).

screeplot(PCA)
plot(eigen(cor(d))$values,type='l',ylab='valores propios')
# Codo en 3 entonces m=2.




# 5.6. Prueba de esfericidad.

# Contraste de esfericiddad de Y_(m+1), ... , Y_k:
#   H0: lambda_(m+1) = lambda_(m+2) = ... = lambda_k 
# si se acepta, no debemos dar preferencia a una sobre otra

# Por ejemplo tomamos m=2. 

L <- eigen(cor(d))$values
ma <- mean(L[3:4])
mg <- exp(mean(log(L[3:4])))

n<-length(d[,1]) # dim. de cada variable (numero de estados de USA).
k<-length(d) # dim. de variables iniciales.
m<-2 
T<-(n-(2*k+11)/6)*(k-m)*log(ma/mg) # estadistico.
gl <-0.5*(k-m-1)*(k-m+2) # grados de libertad.

1-pchisq(T,gl) #p-valor=0.05092569 > 0.05 .
# "Acepto H0", luego no debemos dar preferencia a una componente, Yk con k>2, sobre otra.
# No hace falta añadir mas componentes.

qchisq(0.95,gl) 

# Grafica de la funcion de densidad de una chi-cuadrado con k grados de libertad.
curve(dchisq(x,k),0,50) 














