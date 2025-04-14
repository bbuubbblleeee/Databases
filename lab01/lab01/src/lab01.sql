CREATE TABLE IF NOT EXISTS Interaction(
    interaction_id SERIAL PRIMARY KEY,
    interaction_name VARCHAR(255) NOT NULL,
    description text,
    subject VARCHAR(255) NOT NULL,
    duration INTERVAL
);

CREATE TABLE IF NOT EXISTS Species(
    species_category VARCHAR(255) NOT NULL PRIMARY KEY,
    class VARCHAR(255),
    natural_habitat VARCHAR(255),
    lifespan_years INT CHECK (lifespan_years IS NULL OR lifespan_years > 0)
);

CREATE TABLE IF NOT EXISTS Location(
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(255),
    description text,
    coordinates POINT NOT NULL
);

CREATE TABLE IF NOT EXISTS Character(
    character_id SERIAL PRIMARY KEY,
    age INT CHECK (age IS NULL OR age > 0),
    object VARCHAR(255) NOT NULL,
    character_category VARCHAR(255) NOT NULL,
    characterisation VARCHAR(255),
    current_location_id INT,
    FOREIGN KEY(current_location_id) REFERENCES Location(location_id) ON DELETE CASCADE,
    FOREIGN KEY(character_category) REFERENCES Species(species_category) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Relocation(
    relocation_id SERIAL PRIMARY KEY,
    relocation_name VARCHAR(255) NOT NULL,
    description text,
    speed INT CHECK (speed IS NULL OR speed > 0),
    direction VARCHAR(255),
    start_location_id INT,
    destination_location_id INT,
    manner VARCHAR(255),
    FOREIGN KEY(start_location_id) REFERENCES Location(location_id) ON DELETE CASCADE ,
    FOREIGN KEY(destination_location_id) REFERENCES Location(location_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Sound(
    sound_id SERIAL PRIMARY KEY,
    sound_type VARCHAR(255),
    volume INT CHECK (volume IS NULL OR volume > 0),
    duration INTERVAL,
    characterisation VARCHAR(255),
    location_id INT
);

CREATE TABLE IF NOT EXISTS Character_interaction(
     interaction_id INT NOT NULL,
     character_id INT NOT NULL,
     PRIMARY KEY(interaction_id, character_id),
     FOREIGN KEY(interaction_id) REFERENCES Interaction(interaction_id) ON DELETE CASCADE ,
     FOREIGN KEY(character_id) REFERENCES Character(character_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Location_sound(
    location_id INT NOT NULL,
    sound_id INT NOT NULL,
    PRIMARY KEY(location_id, sound_id),
    FOREIGN KEY(location_id) REFERENCES Location(location_id) ON DELETE CASCADE ,
    FOREIGN KEY(sound_id) REFERENCES Sound(sound_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Character_relocation(
    character_id INT NOT NULL,
    relocation_id INT NOT NULL,
    PRIMARY KEY(character_id, relocation_id),
    FOREIGN KEY(character_id) REFERENCES Character(character_id) ON DELETE CASCADE ,
    FOREIGN KEY(relocation_id) REFERENCES Relocation(relocation_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Character_sound(
    character_id INT NOT NULL,
    sound_id INT NOT NULL,
    PRIMARY KEY(character_id, sound_id),
    FOREIGN KEY(character_id) REFERENCES Character(character_id) ON DELETE CASCADE ,
    FOREIGN KEY(sound_id) REFERENCES Sound(sound_id) ON DELETE CASCADE
);
-- CREATE TABLE IF NOT EXISTS Q(
--     id serial primary key,
--     age INTEGER ,
--     attr2 integer ,
--     UNIQUE(age, attr2)
-- );
--
-- INSERT Into Q(age, attr2) VALUES (null, null);
INSERT INTO Interaction (interaction_name, subject, description, duration) VALUES
    ('Throw', 'Ball' , 'Throwing the ball to another character', '00:00:05'),
    ('Kick', 'Ball', 'Kicking the ball ', '00:00:05'),
    ('Read', 'Book', 'Reading the book for half an hour', '00:30:00'),
    ('Read', 'Magazine', 'Reading the magazine for an hour', '01:00:00'),
    ('Play', 'Guitar','Playing the guitar', '00:15:30'),
    ('Eat', 'Food', 'Eating the food', '00:20:00');


INSERT INTO Species (species_category, class, natural_habitat, lifespan_years) VALUES
    ('Human', 'Mammal', 'Various', 80),
    ('Dog', 'Mammal', 'Domestic', 15);
INSERT INTO species(species_category, class, natural_habitat) VALUES
    ('Bird', 'Aves', 'Mountains');
INSERT INTO species(species_category, class) VALUES
    ('Сactus', 'Bicotyledons'),
    ('Turtle', 'Reptiles');

INSERT INTO Location (location_name,coordinates, description) VALUES
    ('Park', POINT(40.7128, -74.0060), 'A green area with trees'),
    ('City Center', POINT(34.0522, -118.2437), 'Downtown area'),
    ('Forest', POINT(51.5074, -0.1278), 'A large area covered with trees, plants, and wildlife');

INSERT into Location(location_name, coordinates) VALUES
    ('Beach', POINT(25.7907, 80.1300));

INSERT INTO Character (object, age, character_category, characterisation, current_location_id) VALUES
    ('Teenager', 30, 'Human', 'Friendly', 2),
    ('Spitz', 5, 'Dog', 'Big', 1),
    ('Eagle',12, 'Bird', 'Dangerous', 3);

INSERT INTO Character(object, character_category, current_location_id) VALUES
    ('Chihuahua','Dog', 4);

INSERT INTO Relocation (relocation_name, description, speed, direction, start_location_id, destination_location_id) VALUES
    ('Walk', 'A slow walk', 5, 'North', 1, 2),
    ('Flight', 'Fast air travel', 80, 'South', 3, 1);
INSERT INTO Relocation(relocation_name, description, speed, start_location_id, destination_location_id, manner) VALUES
    ('Car drive', 'Driving through the city by car', 60, 2, 3, 'carefully');

INSERT INTO Sound (sound_type, volume, duration, location_id, characterisation) VALUES
    ('Bark', 70, '00:00:05',  2, 'Annoying'),
    ('Laughter', 60, '00:00:07', 1, 'Joyful');
INSERT INTO Sound(sound_type, duration) VALUES
    ('Chirp', '00:00:03');


INSERT INTO Character_interaction (character_id, interaction_id) VALUES
    (2, 2),
    (1, 3),
    (3, 6);

INSERT INTO Character_relocation (character_id, relocation_id) VALUES
    (2, 1),
    (1, 3),
    (3, 2);

INSERT INTO Character_sound (character_id, sound_id) VALUES
    (2, 1),
    (1, 2),
    (3, 3);

INSERT INTO Location_sound(location_id, sound_id) VALUES
    (1, 1),
    (2, 2),
    (1, 2);