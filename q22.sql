SELECT
	CNTRYCODE,
	COUNT(*) AS NUMCUST,
	SUM(C_ACCTBAL) AS TOTACCTBAL
FROM
	(
	SELECT
		SUBSTRING(C_PHONE, 1 , 2) AS CNTRYCODE,
		C_ACCTBAL
	FROM
		customer
	WHERE
		SUBSTRING(C_PHONE , 1 , 2) IN
		('20', '40', '22', '30', '39', '42', '21')
	AND C_ACCTBAL > (
			SELECT
				AVG(C_ACCTBAL)
			FROM
				customer
			WHERE
				C_ACCTBAL > 0.00
			AND SUBSTRING(C_PHONE , 1 , 2) IN
			('20', '40', '22', '30', '39', '42', '21')
	)
	AND NOT EXISTS (
		SELECT
			*
		FROM
			orders
		WHERE
			O_CUSTKEY = C_CUSTKEY
		)
	) AS CUSTSALE
GROUP BY
	CNTRYCODE
ORDER BY
	CNTRYCODE
