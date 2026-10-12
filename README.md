# Sistema de Gestión de Bases de Datos — ANFP Chile

## Contexto del Proyecto

La Asociación Nacional de Fútbol Profesional administra las competencias de fútbol profesional en Chile. Con el objetivo de resolver problemas de duplicidad de datos, inconsistencias y fragmentación en planillas independientes, se diseñó e implementó una base de datos relacional normalizada en que centraliza la información de jugadores, cuerpo de planta, clubes, asociaciones, escuelas formativas e historial de contratos.

---

## Estructura del Repositorio

El repositorio está organizado con los siguientes archivos y entregables:

| Archivo / Carpeta | Descripción |
| :--- | :--- |
| `PRY2204_EFT_S9_Formato_respuesta (Forma A).docx` | Informe técnico con la documentación formal y capturas del proyecto. |
| `PRY2204_EFT_S9.sql` | Script DDL (creación de objetos) y DML (poblamiento e informes SELECT). |
| `Encargo_Semanal.zip` | Archivo comprimido con el diseño `.dmd` y carpetas de recursos de Oracle Data Modeler. |
| `README.md` | Documentación general del repositorio. |

---

## 🛠️ Fases del Desarrollo

### Fase 1: Modelo Entidad-Relación Extendido (MER-E)
* **Herramienta:** Oracle SQL Developer Data Modeler (Notación Barker).
* **Modelado:**
  * Implementación de **herencia** mediante el supertipo `TRABAJADOR` y los subtipos `JUGADOR` y `PERSONAL_PLANTA`.
  * Definición de relaciones clave: asociaciones, escuelas formativas, dominio de idiomas y contratos históricos con clubes.

### Fase 2: Modelo Relacional Normalizado (MR)
* **Transformación y Normalización:**
  * Transformación del modelo conceptual a esquema relacional físico.
  * Aplicación de reglas hasta **3FN**: eliminación de atributos multivaluados (`DOMINIO_IDIOMA`) y resolución de relaciones M:N (`HISTORIAL_CLUB`).
  * Definición de claves primarias (`PK`), claves foráneas (`FK`) y restricciones de clave única (`UN`) en la columna `nombre_club`.

### Fase 3: Implementación Física (DDL y DML)
* **Entorno:** Oracle SQL Developer / Base de Datos Oracle 19c / Oracle Cloud.
* **Aspectos destacados:**
  * ** IDENTITY Column:** Clave primaria autoincremental para la tabla `NACIONALIDAD` (inicia en 210, incremento de 2 en 2).
  * **Secuencias:** Creación de `seq_club_futbol` para la generación automática de IDs de clubes (inicia en 703, incremento de 4 en 4).
  * ** Restricciones Check (CK):** Validación de fecha de creación en `ASOCIACION` ($\ge 31/12/1980$).
  * **Poblamiento:** Carga secuencial garantizando la integridad referencial de tablas de catálogo (`REGION`, `COMUNA`, `ASOCIACION`, `NACIONALIDAD`, `CLUB_FUTBOL`).

### Fase 4: Consultas de Recuperación (SELECT)
1. **Informe 1 (Asociaciones Profesionales):** Filtra asociaciones de tipo profesional creadas después del año 2000, formateadas con prefijos dinámicos y ordenadas descendentemente.
2. **Informe 2 (Patrimonio de Clubes en USD):** Calcula el patrimonio de clubes en pesos chilenos y su equivalente en dólares (tipo de cambio $955/USD), filtrando entidades profesionales cuyo nombre contiene la letra 'a' y superan los $200.000.000 CLP.

---
