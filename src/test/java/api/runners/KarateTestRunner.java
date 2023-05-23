package api.runners;

import com.intuit.karate.junit5.Karate;

public class KarateTestRunner {

	@Karate.Test 
	public Karate runTests(){
		// run() method required path to feature files.
		// you can use tags() method to specify the Tag
<<<<<<< HEAD
		return Karate.run("classpath:createAndDelteAccount.feature")
=======
		return Karate.run("classpath:getPlan.feature")
>>>>>>> d0f5296a6cee86494f396ae98c137c977b36844d
				.tags("Regression");
	}
}
