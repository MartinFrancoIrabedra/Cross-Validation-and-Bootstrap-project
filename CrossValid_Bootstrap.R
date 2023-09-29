library(ISLR)
set.seed (1)
train = sample(x = 392, size = 196)


lm.fit=lm(mpg ~ horsepower, data=Auto, subset=train)


attach(Auto)
mean((mpg-predict(lm.fit, Auto))[-train]^2)



lm.fit2 = lm(mpg ~ poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
lm.fit3=lm(mpg ~ poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3,Auto))[-train]^2)



set.seed(2)
train=sample(392,196)
lm.fit=lm(mpg~horsepower,subset=train)
mean((mpg-predict(lm.fit,Auto))[-train]^2)
lm.fit2=lm(mpg~poly(horsepower,2),data=Auto,subset=train)
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
lm.fit3=lm(mpg~poly(horsepower,3),data=Auto,subset=train)
mean((mpg-predict(lm.fit3,Auto))[-train]^2)



glm.fit=glm(mpg~horsepower,data=Auto)
coef(glm.fit)



lm.fit=lm(mpg~horsepower,data=Auto)
coef(lm.fit)

####### Cross Validation


library(boot)
glm.fit=glm(mpg~horsepower,data=Auto)
cv.err=cv.glm(Auto,glm.fit)
cv.err$delta



cv.error=rep(x = 0, times = 5)
for (i in 1:5){
        glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
        cv.error[i]=cv.glm(Auto,glm.fit)$delta[1]
}

plot(cv.error, type="b")



set.seed(17)
cv.error.5= rep(0,5)
cv.error.5.bias_adj= rep(0,5)
for (i in 1:5){
        glm.fit=glm(mpg~poly(horsepower,i),data=Auto)
        cv.error.5[i]=cv.glm(Auto,glm.fit,K=5)$delta[1]
        cv.error.5.bias_adj[i]=cv.glm(Auto,glm.fit,K=5)$delta[2]
}
plot(cv.error.5, type="b", ylim = range(cv.error.5, cv.error.5.bias_adj))
lines(y=cv.error.5.bias_adj, x=1:5, "b", lty=2)



alpha.fn=function(data,index){
        X=data$X[index]
        Y=data$Y[index]
        return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}


## -----------------------------------
# ? Portfolio # Portfolio data of the ISLR R-package
alpha.fn(data = Portfolio, index = 1:100)

set.seed(1)
alpha.fn(Portfolio,sample(100,100,replace=T))




##### Bootstrap

set.seed(1)
boot(Portfolio,alpha.fn,R=1000)



boot.fn=function(data,index)
        return(coef(lm(mpg~horsepower,data=data,subset=index)))
boot.fn(Auto,1:392)



set.seed(1)
boot.fn(Auto,sample(392,392,replace=T))
boot.fn(Auto,sample(392,392,replace=T))


boot(Auto,boot.fn,1000)


summary(lm(mpg~horsepower,data=Auto))$coef



boot.fn=function(data,index)
        coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,subset=index))
set.seed(1)
boot(Auto,boot.fn,1000)
summary(lm(mpg~horsepower+I(horsepower^2),data=Auto))$coef

