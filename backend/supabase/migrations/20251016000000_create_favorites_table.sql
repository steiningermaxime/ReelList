-- Create favorites table for Mon Ciné-Club
CREATE TABLE IF NOT EXISTS favorites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tmdb_id INTEGER UNIQUE NOT NULL,
    title TEXT NOT NULL,
    poster_url TEXT,
    overview TEXT,
    release_year INTEGER,
    status TEXT NOT NULL CHECK (status IN ('watchlist', 'watched')),
    personal_rating INTEGER CHECK (personal_rating >= 1 AND personal_rating <= 5),
    personal_comment TEXT,
    added_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    watched_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index on tmdb_id for faster lookups
CREATE INDEX IF NOT EXISTS idx_favorites_tmdb_id ON favorites(tmdb_id);

-- Create index on status for filtering
CREATE INDEX IF NOT EXISTS idx_favorites_status ON favorites(status);

-- Create index on added_at for sorting
CREATE INDEX IF NOT EXISTS idx_favorites_added_at ON favorites(added_at DESC);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to automatically update updated_at on row update
CREATE TRIGGER update_favorites_updated_at
    BEFORE UPDATE ON favorites
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Add some comments for documentation
COMMENT ON TABLE favorites IS 'Stores user favorite movies from TMDB';
COMMENT ON COLUMN favorites.tmdb_id IS 'The Movie Database (TMDB) movie ID';
COMMENT ON COLUMN favorites.status IS 'Movie status: watchlist (to watch) or watched (already seen)';
COMMENT ON COLUMN favorites.personal_rating IS 'User rating from 1 to 5 stars';
COMMENT ON COLUMN favorites.watched_at IS 'Date when the user marked the movie as watched';
