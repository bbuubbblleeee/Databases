-- Первый запрос

EXPLAIN ANALYZE SELECT "Н_ВЕДОМОСТИ"."ЧЛВК_ИД", "Н_ОЦЕНКИ"."КОД" FROM "Н_ОЦЕНКИ"
    LEFT JOIN "Н_ВЕДОМОСТИ"
        ON "Н_ОЦЕНКИ"."КОД" = "Н_ВЕДОМОСТИ"."ОЦЕНКА"
    WHERE "Н_ОЦЕНКИ"."ПРИМЕЧАНИЕ" < 'удовлетворительно' AND
        "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" > 153285 AND
        "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" > 105590;


