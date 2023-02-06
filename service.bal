import ballerinax/worldbank;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - string name with hello message or error
    resource function get Information(string Country = "INDIA") returns json|error {
        // Send a response back to the caller.

        worldbank:Client worldbankEp = check new ();
        worldbank:IndicatorInformation[] PopulationByCountryResponse = check worldbankEp->getPopulationByCountry(countryCode = Country);
        float PopulationOfCountry = <float>(PopulationByCountryResponse[0]?.value ?: 0) / 100000;
        worldbank:IndicatorInformation[] getGDPByCountryResponse = check worldbankEp->getGDPByCountry(countryCode = Country);
        float GDPOfCountry = <float>(getGDPByCountryResponse[0]?.value ?: 0);
        json CountryInfo = {Country: Country, PopulationOfCountry: PopulationOfCountry, GDPOfCountry: GDPOfCountry};
        return CountryInfo;
    }
}
