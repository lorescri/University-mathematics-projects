# Examen de la primera parte de estadistica multivariante.


# Cargo la carpeta donde tengo guardadas los datos de Multivariante
setwd("C:Users/loreshu/Desktop/Mathematics-2019/University-mathematics-projects/Mathematics 22-23/Multivariate statistics/Multiple linear regression/Exercises and data") 


# Cargo los datos que voy a utilizar en el ejercicio.
load("C:/Users/loreshu/Desktop/Mathematics-2019/University-mathematics-projects/Mathematics 22-23/Multivariate statistics/Multiple linear regression/Exercises and data/Regresion_data.RData")
# Este paso tambien se puede hacer manualmente,
# configurando el espacio de trabajo (Environment).


# Vamos a utilizar la libreria car.
# Este paquete hay que descargarlo manualmente en la ventana de packages
library(car)
library(lmtest)


# Cargamos los datos.
attach(homicidios) 
datos=data.frame(homicidios)

# Vemos las variables que contiene.
str(datos) 
# Vemos los datos en forma de tabla.
View(datos) 



#-------------- MODELO DE REGRESION ------------

regre <- lm(y~x1+x2+x3, data=datos) 
# Obtenemos el resumen del modelo.
summary(regre) 


#---------- CONTRASTES DEL MODELO (anova) --------

anova(regre)

# Los p-valores obtenidos en cada una de las variables, nos permiten realizar los 
# siguientes contrastes:
#    H0: B0=0      (Hipotesis nula)
#    H1: B0!=0 <---Acepto pues p-valor<< (p=3.629e-06<0.05)

#    H0: Bsem=0
#    H1: Bsem!=0 <-Acepto pues p-valor<< (p=8.03e-5<0.05)

#    etc

# El ultimo p-valor sirve para realiar el Test de regresion:
#    H0: B1=...=Bk=0      (No incluimos B0)
#    H1: no todos son 0   <---Acepto, pues p-valor<< (p=2.2e-16<0.05)
# El valor del estadistico (F-statistic) es F=24.02


# Estudiamos la variacion de las medias (los efectos alphas) 
#mediaTotal + alpha_i = media_i
#   H0: Hipotesis nula
#   H1: Hipotesis alternativa

vif(regre) 
# Si alguno de los cif es >= 5, entonces los coefs están mal estimados,
# debido a la multicolinealidad. 
# Observamos que son todos <5.



#------------- MODELO AJUSTADO -------------- 
#Y^=B0^+B1^X1+B2^X2+B3^X3

# Añadimos las predicciones (los Y^)
datos$ajustados <- fitted(regre)

# Añadimos las diferencias entre el valor real y el ajustado (los residuos)
datos$residuos <- residuals(regre)

#------------- MEDIA DE BONDAD -----------------
# Consiste en la r^2: 0.8183 --> 81,83% > 70% luego es un buen modelo.

# Coeficiente de determinación 
# El R2 mide la bondad de ajuste, que describe lo bien que se ajusta 
# un conjunto de observaciones.
# FUENTE: LA WIKI.

# Si el R2 no varía mucho, 
# entonces sigue siendo un buen modelo al quitarle alguna variable.


#----------- CONDICIONES INICIALES -------------

attach(datos)


# LINEALIDAD
# Redondeamos.
valores=as.factor(round(ajustados,4))
# Esto es hacer el contraste de la falta de ajustes.

# Nuevo modelo de regresion con factores.
regreFA <- lm(y~valores,data=datos) 
anova(regre,regreFA) 
# p-valor << entonces rechazo H0, no hay linealidad.


# INCORRELACION
dwtest(regre, alternative="two.sided") 
#p-valor=0.9827>0.5 acepta H0, las variables son incorreladas.


# NORMALIDAD
shapiro.test(residuos) 
# p-valor=0.0007793<0.5 entonces rechazo H0, no hay normalidad.


# HOMOGENEIDAD DE VARIANZAS (Homocedasticidad)
leveneTest(datos$residuos, as.factor(valores)) 
# p-valor << luego no hay homogeneidad de varianzas.
# warning porque no es muy fiable.

plot(regre, 1:6)


#----------- Eliminacion de dos variables ------------

# Como antes teníamos los valores ajustados y residuos, los eliminamos de esta tabla.
datos=data.frame(homicidios) 
regre <- lm(y~x1+x2+x3,data=datos)
summary(regre)
# R2=0.8183
# Quitamos la variable de mayor p-valor, que en este caso es x_1.

regre7 <- lm(y~x2+x3,data=datos)
summary(regre7)
# R2=0.802 (Casi no ha disminuido)
# La variable de mayor p-valor es x_2, la quitamos.

regre6 <- lm(y~x3, data=datos)
summary(regre6)
# R2=0.748.

# La(s) variable(s) que queda parece bastante significativa(s).


# El anova sirve para comparar dos modelos de regresión, 
# por ejemplo, ver si de un regre(N) a un regre(N-1) mejora o no.

# De manera general, los contrastes de modelo se formulan así:
#     H0: los dos modelos son equivalentes.
#     H1: uno de los modelos es mejor que el otro.
# Si p-valor<< rechazamos H0, y por tanto uno de los modelos es mucho mejor que el otro.
# A continuacion comprobamos si se verifican las condiciones iniciales.


attach(datos)

#------------ Condiciones iniciales ------------
datos$ajustados6 <-fitted(regre6)
datos$residuos6 <- residuals(regre6)


# LINEALIDAD 
# Redondeamos.
valores=round(datos$ajustados6, 4) 
regreFA <- lm(y~as.factor(valores),data=datos) # Nuevo modelo de regresion con factores
anova(regre6,regreFA) 
# p-valor =0.008733 <0.05 entonces rechazo H0, no hay linealidad.

# INCORRELACION
dwtest(regre6, alternative="two.sided") 
# p-valor=0.2796 > 0.5 no acepta H0, las variables no son incorreladas.

# NORMALIDAD
shapiro.test(datos$residuos6) 
# p-valor=0.9079 > 0.5 

# HOMOGENEIDAD DE VARIANZAS
leveneTest(datos$residuos6, as.factor(valores)) 
# p-valor << luego no hay homogeneidad de varianzas.
# Warning porque no es muy fiable.


predict(regre, data.frame(x1=825 , x2= 16.5, x3=6.75),
        interval="confidence", level=0.98) 

predict(regre6, data.frame(x1=825 , x2= 16.5, x3=6.75),
        interval="confidence", level=0.98) 


predict(regre6, data.frame( x3=6.75),
        interval="confidence", level=0.98) 




summary(regre6)