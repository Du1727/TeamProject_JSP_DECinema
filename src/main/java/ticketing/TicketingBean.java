package ticketing;

public class TicketingBean {
	private String movieNm;
	private String movieDmType;
	private String movieAge;
	private String screeningDate;
	private String regionNm;
	private String theaterNm;
	
	public TicketingBean(String movieNm, String movieDmType, String movieAge, String screeningDate, String regionNm,
			String theaterNm) {
		super();
		this.movieNm = movieNm;
		this.movieDmType = movieDmType;
		this.movieAge = movieAge;
		this.screeningDate = screeningDate;
		this.regionNm = regionNm;
		this.theaterNm = theaterNm;
	}

	public String getMovieNm() {
		return movieNm;
	}

	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}

	public String getMovieDmType() {
		return movieDmType;
	}

	public void setMovieDmType(String movieDmType) {
		this.movieDmType = movieDmType;
	}

	public String getMovieAge() {
		return movieAge;
	}

	public void setMovieAge(String movieAge) {
		this.movieAge = movieAge;
	}

	public String getScreeningDate() {
		return screeningDate;
	}

	public void setScreeningDate(String screeningDate) {
		this.screeningDate = screeningDate;
	}

	public String getRegionNm() {
		return regionNm;
	}

	public void setRegionNm(String regionNm) {
		this.regionNm = regionNm;
	}

	public String getTheaterNm() {
		return theaterNm;
	}

	public void setTheaterNm(String theaterNm) {
		this.theaterNm = theaterNm;
	}
}
