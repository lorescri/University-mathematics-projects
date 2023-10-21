# Práctica de regresion lineal. 21/02/23

# Ejercicio 11. Ejemplo de MODELO ANOVA.


# Añadimos los datos a utilizar.
attach(ph)
datos<-ph
str(datos)

# Como tenemos una C en cada una de las temperaturas, hay que tratarlo como factor.
Temp=as.factor(Temp) 
# Sino daría error.


# Hacemos regresion.
modelo <- lm(y ~ Temp, data=datos) 
summary(modelo)
#alfa_1 = 99.8333, alfa_2 = 2.2200 , alfa_3=3.6533


# Analysis of value.
mod<-aov(y ~ Temp, data=datos)
summary(mod)

# El . indica la iteraccion entre todas las variables, Temp, ph, c
#model<-aov(y ~ Temp.ph, data=datos)
#summary(model)

#y ~ Temp*ph*C
#Temp=pH(A=B)
#Poniendo el asterisco conseguimos la interaccion entre toda las variables:
#A+B+C+AB+AC+BC

# Test de normalidad
shapiro.test(residuals(mod))

by(residuals(mod), Temp, shapiro.test)#este no da error!!!

bartlett.test(residuals(mod), Temp)



