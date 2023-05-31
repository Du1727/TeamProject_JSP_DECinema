package ticketing;


public class MovieInfoBean {
	private int idx;
	private String movieNm;
	private String movieDmType;
	private String ageLimit;
	private String posterPath;
	private String director;
	private String actor;
	private String genre;
	private String intro;
	private String openDt;
	private String endDt;
	private String runtime;
	private String trailerPath;
	
	public MovieInfoBean() {
		
	}
	
	public MovieInfoBean(int idx, String movieNm, String movieDmType, String ageLimit, String posterPath,
			String director, String actor, String genre, String intro, String openDt, String endDt, String runtime,
			String trailerPath) {
		super();
		this.idx = idx;
		this.movieNm = movieNm;
		this.movieDmType = movieDmType;
		this.ageLimit = ageLimit;
		this.posterPath = posterPath;
		this.director = director;
		this.actor = actor;
		this.genre = genre;
		this.intro = intro;
		this.openDt = openDt;
		this.endDt = endDt;
		this.runtime = runtime;
		this.trailerPath = trailerPath;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getAgeLimit() {
		return ageLimit;
	}
	public void setAgeLimit(String ageLimit) {
		this.ageLimit = ageLimit;
	}
	public String getPosterPath() {
		return posterPath;
	}
	public void setPosterPath(String posterPath) {
		this.posterPath = posterPath;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getRuntime() {
		return runtime;
	}
	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}
	public String getTrailerPath() {
		return trailerPath;
	}
	public void setTrailerPath(String trailerPath) {
		this.trailerPath = trailerPath;
	}
}
