##Apuntes de triggers SQL 13/05/2025

Trigers:
Acción => Reacción

---

###Tipos de triggers
- LMD
- LDD

---

###Trigers LDM:
INSERT, UPDATE, DELETE

###LDD
CREATE, ALTER, DROP

---

#Sintaxis:

```
CREATE TRIGGER *NOMBRE* ON *TABLA/VISTA*
AFTER/INSTEAD *STATEMENT*
BEGIN

***CÓDIGO SQL***

END
```

---
##¡IMPORTANTE!
###TABLAS DELETED E INSERTED IMPORTANTE
- DELETED: Tabla temporal donde se almacenan los registros borrados.
- INSERTED: Tabla temporal donde se almacenan los registros insertados.
---



