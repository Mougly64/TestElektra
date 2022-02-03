# TestElektra
comparto la prueba solicitada por Roger Chavez Garcia 

# Título del Proyecto TestElektra

_Acá va un párrafo que describa lo que es el proyecto_

## Comenzando 🚀
### Arquitectura utilizada MVC 📋

se utilizo una arquitectura en MVC, ya que el alcance de la aplicación era corto y no requeria mucho negocio adicional cómo para implementar una arquitectura MVC, tampoco se utilizo una arquitectura VIPER ya que tampoco requeria de muchas pantallas para implementar.

### Librerias externas utilizadas 🔧

Para este proyecto no se utilizaron ningunas librerias de terceros, se pudo haber implementado AlamoFire para el consumo de servicios, pero se utilizo el consumo de manera nativa con UrlSessions, para la presentacion de imagenes se pudo usar KingFisher pero no era soportado por iOS 10.

### Que parte(s) de tu codigo pueden ser mejoradas si tuvieras m s tiempo
se pudo haber mejorado la parte de algunos metodos para llamar a la base de datos incluyendolos en DataBaseHelper, tambien la pantalla de detalle pudo ser mejorada mostrando mas datos con un diseño mejor.

### ¿Cules fueron los mayores problemas que encontraste en el desarrollo de la practica y como los resolviste?
el conflico mas grande fue el tener que realizar migrations en core data por el cambio de tipo de datos, la manera mas rapida de solventarlo fue desinstalando la aplicación e iniciandola de nuevo, ya que no he implementado migrations para estos casos.

### Si alguno de los puntos solicitados no los concluiste, menciona por qué
la parte de los headers cutomized, pude haber implementado un header customized con un uitableviewcell

## Construido con 🛠️

Xcode
URLSessions
CoreData
StoryBoards
xibs
protocolos y delegados

## Versionado XCode📌
Xcode 13.2.1

## Autores ✒️

_Menciona a todos aquellos que ayudaron a levantar el proyecto desde sus inicios_

* **Luis Angel Rodríguez Angeles** - *Trabajo Inicial* - [Mougly64](https://github.com/Mougly64)

## Licencia 📄

Este proyecto está bajo la Licencia (Luan Road)
