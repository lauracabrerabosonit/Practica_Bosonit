# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 11:41:57 2023

@author: laura.cabrera
"""

from pyspark.sql.types import *
from pyspark.sql import SparkSession
from pyspark.sql import Window
from pyspark.sql.functions import *
import pyspark.sql.functions as F

import pyspark



#Creamos la sesión

spark = (SparkSession
        .builder
        .appName("PadronPySpark")
        .getOrCreate())


#Importamos el archivo

#HEADER (los datos vienen con una linea al principio con la estructura)
#INFERSCHEMA (queremos utilizar el header como schema)
#DELIMITER (indicamos le caracter que separa los valores de las columnas distintas)
#QUOTES (delimita los valores de las columnas)
#EMPTYVALUE (convierte los nulls en otro valor)


#Ruta del csv
ruta = "C:/Practica_Bosonit/Ejercicios_Padron/estadisticas202212.csv"

datos_padron = (spark.read.format("csv")
             .option("header", "true")
            .option("inferSchema", "true")
            .option("delimiter", ";")
            .option("quotes", "\"")
            .option("emptyValue", 0)
            .load(ruta))

datos_padron.show(5)



padron_txt_2 = datos_padron.select([(trim(i[0])).alias(i[0]) for i in datos_padron.select("*").dtypes])

#padron_txt_2.show(5)




