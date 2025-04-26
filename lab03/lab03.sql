CREATE OR REPLACE FUNCTION upd_quantity_location()
    returns trigger as $$
BEGIN
    IF TG_OP = 'UPDATE' AND OLD.current_location_id IS DISTINCT FROM NEW.current_location_id THEN
        UPDATE Location
        SET quantity = quantity - 1
        WHERE location_id = OLD.current_location_id;

        UPDATE Location
        SET quantity = quantity + 1
        WHERE location_id = NEW.current_location_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Location
        SET quantity = quantity - 1
        WHERE location_id = OLD.current_location_id;
    ELSIF TG_OP = 'INSERT' THEN
        UPDATE Location
        SET quantity = quantity + 1
        WHERE location_id = NEW.current_location_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER upd_location_quantity
    AFTER INSERT OR DELETE OR UPDATE OF "current_location_id" ON Character
    FOR EACH ROW
EXECUTE FUNCTION upd_quantity_location();