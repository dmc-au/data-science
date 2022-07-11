

CREATE FUNCTION calculateTax(amount  integer) 
RETURNS float
AS $$
	DECLARE
		taxAmount float;
		
	BEGIN
		IF(amount <= 18200) THEN
			taxAmount = 0;
		ELSIF (amount <= 37000) THEN
			taxAmount = (amount - 18200)*(19.0/100.0);
		ELSIF (amount <= 90000) THEN
			taxAmount = (amount - 37000)*(32.5/100.0) + 3572;
		ELSIF (amount <= 180000) THEN
			taxAmount = (amount - 90000)*(37.0/100.0) + 20797;
		ELSE
			taxAmount = (amount - 180000)*(45.0/100.0) + 54097;
		END IF;
		
		return taxAmount ;
	END;
$$ LANGUAGE plpgsql;

-- lets call the function for testing 
SELECT * FROM calculateTax(97520) ;

