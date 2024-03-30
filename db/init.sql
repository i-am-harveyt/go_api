CREATE TABLE ad (
	id SERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	start_at TIMESTAMP NOT NULL,
	end_at TIMESTAMP NOT NULL
);

CREATE TABLE condition (
	id SERIAL PRIMARY KEY,
	ad_id SERIAL REFERENCES ad(id),
	age_start SMALLINT,
	age_end SMALLINT,
	gender TEXT[],
	country TEXT[],
	platform TEXT[]
);

CREATE INDEX idx_ad_start_at ON ad (start_at);
CREATE INDEX idx_ad_end_at ON ad (end_at);

CREATE INDEX idx_condition_age_start ON condition (age_start);
CREATE INDEX idx_condition_age_end ON condition (end_at);
