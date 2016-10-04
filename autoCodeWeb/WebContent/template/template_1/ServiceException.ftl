package ${basePackage};

public class ServiceException extends RuntimeException{
    private static final long serialVersionUID = 6757986084644052746L;
    private String errorMessage;

    public ServiceException(String errCode) {
        this(errCode, errCode, null);
    }
    
    public ServiceException(String errCode, String message, Throwable cause) {
        super(message, cause);
        this.errorMessage = errCode;
    }

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
}