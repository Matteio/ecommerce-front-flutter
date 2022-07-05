
enum SortTipi{ CRES, DECR, }

enum GetTipi{ FILTRA, PAGINAZIONE, }

class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "shopSite";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8000";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "shop";
  static final String CLIENT_ID = "shop-client";
  static final String CLIENT_SECRET = "f8oZ7S958TGyqa9uOeic5xII3p5UFYLw";
  static final String REQUEST_LOGIN = "auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "auth/realms/" + REALM + "/protocol/openid-connect/logout";


  // requests
  static final String REQUEST_SEARCH_PRODUCTS = "/prodotti/cerca";
  static final String REQUEST_ADD_USER = "/utenti/crea";
  static final String REQUEST_EDIT_PRODUCTS="/prodotti/edit";
  static final String REQUEST_ADD_PRODUCTS="/prodotti/add";
  static final String REQUEST_DELETE_PRODUCTS="/prodotti/delete/";

  // states
  static final String STATE_CLUB = "club";
  static const int PAGE_LIMIT=10;

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_USER_NOT_FOUND="ERROR_USER_NOT_FOUND";
  static final String RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE="ERROR_QUANTITY_PRODUCT_UNAVAILABLE";
  static final String RESPONSE_ERROR_PRODUCT_NOT_FOUND="ERROR_PRODUCT_NOT_FOUND";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";
}//Constants