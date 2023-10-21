# Práctica de regresion lineal. 21/02/23

# Ejercicio 9.

# Añadimos los datos que vamos a utilizar.
attach(peso)
datos<- peso
str(datos)

# Creamos el modelo de regresion lineal.
modelo <- lm(pesor ~ sem + pesom + pesop + tallam + tallap, data=datos) 

# Coeficientes
modelo$coefficients


#----------------- Media de bondad ---------------

# Obtenemos media de bondad.
summary(modelo) 
# R^2= 0.8139 ~ 81.39%
# R_a^2~ 80%
# El residual estándar error 0.1799 es S_r^3 varianza

# Cuantil de la distribución t de Student.
qt94<-qt(0.025,94,lower.tail=FALSE)  
# Con lower. tail= FALSE nos da la cola derecha.

# Intervalos de confianza
confint(modelo) 


#----------------- CONTRASTE DEL MODELO ------------

# Hacemos el contraste de que todas los betas i son 0
# F(y)= SS_E/5/SS_R/94=82.23 <--------------summary(modelo)
# Descartamos esa hipotesis pq el p-value es muy bajo, p-value: < 2.2e-16

# Pasamos a contrastes individuales.
# Mirando los p valores vemos que la altura de la madre es de 0.23 entonces aceptamos H0.
# Concluimos que esa beta i es 0.
# Al eliminar una variable, tenemos que repetir el modelo sin ella, pues el resto pueden cambiar.

# Matriz de covarianzas
vcov(modelo) 

# Si dividimos por 0.1799^2 obtenemos (X^TX)^-1
# pues Cov b^= sigma^ ^2 (X^TX)^(-1)

# Análisis del modelo
anova(modelo)


#----------------- Modelo ajustado --------------

attributes(modelo)
names(modelo)

# Modelo$fitted
datos$ajustes<- fitted(modelo)

# Modelo$residuals
datos$residuos<- residuals(modelo) 

View(datos)
attach(datos)


cbind(pesor, ajustes, residuos)[1:10, ]

# Añadimos el paquete car para utilizar la funcion vif.
library(car)
vif(modelo)

-------------------------------------

# Apartado b)
plot(modelo, 1:6)
# Este apartado consiste en analizar las graficas.

-------------------------------------

# Apartado c)
# Hacemos el contraste de regresion.
modelo0<- lm(pesor ~ 1,data = datos)
summary(modelo0)
anova(modelo0, modelo)
# Esto es para considerar los grupos de igual valor de predictores

modeloLin<- lm(pesor ~ as.factor(round(ajustes,4)),data=datos)
summary(modeloLin)
anova(modelo, modeloLin)

library(lmtest)
# Obtenemos un error, porque para poder usarlo necesitamos que haya al menos 2 individuos en cada grupo.
bartlett.test(residuos, as.factor(round(ajustes,4)))
leveneTest(residuos, as.factor(round(ajustes,4)))

# Con esta función podemos ver si los residuos siguen una normal, pero no funciona
# pues necesitamos al menos 3 individuos en cada grupo para estudiar la normalidad
by(residuos, as.factor(round(ajustes,4)), shapiro.test)

# Otro test para ver si es o no normal.
ks.test(residuos, "pnorm")


# Vemos incorrelaciones.

plot(residuos, type= "o")
abline(h=0,col="blue")

#Contraste de incorrelacion
dwtest(modelo, alternative = "two.sided")
#Aceptamos H0, p valor muy alto, aceptamos que sean incorreladas.

# En este caso, no se cumplen las condiciones sobre las varianzas y normalidad.

modelo <- lm(pesor ~ sem + pesom + pesop + tallam + tallap, data=datos)

str(datos)
datos=peso
attach(datos)
str(datos)


# Con . coge todas las variables disponibles
modeloT <- lm(pesor ~ .,data=datos)
summary(modeloT)
anova(modelo, modeloT)

# Cogemos todas las variables salvo la edad de la madre.
mod7 <- lm(pesor ~ . -edadm, data=datos)
summary(mod7)
anova(mod7, modeloT)

mod6 <- lm(pesor ~ . -edadm-tallam, data=datos)
summary(mod6)
anova(mod7, mod6)

# Cuando comparamos 2 modelos la hipotesis nula es que la variable que quitamos 
# tenga coeficiente nulo o no.
# En este ultimo nos equivocariamos un 11% de las veces al rechar la hipotesis,
# lo cual es muy elevado.
# Por tanto, podemos reducir el modelo (quitar variable)

mod5 <- lm(pesor ~ . -edadm-tallam-tabaco, data=datos)
summary(mod5)
anova(mod5, mod6)

mod4 <- lm(pesor ~ . -edadm-tallam-tabaco-tallap, data=datos)
summary(mod4)
anova(mod5, mod4)
# Paramos aqui porque ya no hay ningun p-valor>0.05

# Esto es para considerar los grupos de igual predictores
aj4 <- mod4$fitted.values
res4<-mod4$residuals
lin4<- lm(pesor ~ as.factor(round(aj4,4)),data=datos)
anova(modelo, lin4)

library(lmtest)
# Aqui hay un error porque para poder usarlo necesitamos que haya al menos
# 2 individuos en cada grupo
bartlett.test(residuos, as.factor(round(ajustes,4)))
leveneTest(residuos, as.factor(round(ajustes,4)))

# Practicar cogiendo únicamente como variables, el peso de la madre y 
# las semanas de gestacion.


# Con esto podemos ver si los residuos siguen una normal, pero no funciona
# pues necesitamos al menos 3 individuos en cada grupo para estudiar la 
# normalidad.
by(residuos, as.factor(round(ajustes,4)), shapiro.test)

# Otro test para ver si es o no normal.
ks.test(residuos, "pnorm")


#---------------- Incorrelacion ---------------

plot(residuos, type= "o")
abline(h=0,col="blue")

# Contraste de incorrelacion.
dwtest(modelo, alternative = "two.sided")

mod2<- lm(pesor ~sem+pesom, data=datos)
aj2 <- mod2$fitted.values
res2<-mod4$residuals
lin2<- lm(pesor ~ as.factor(round(aj2,4)),data=datos)
anova(mod2, lin2)

bartlett.test(res2, as.factor(round(aj2,4)))
leveneTest(res2, as.factor(round(aj2,4)))

shapiro.test(res2)
dwtest(mod2, alternative = "two.sided")

