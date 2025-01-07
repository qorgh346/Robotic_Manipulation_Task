package org.ros.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;

import org.ros.uos.ai.jam.Interpreter;
import org.ros.uos.ai.jam.JAM;

public class JamTest {

	public static void main(String[] args) {
//		File f = new File("Test.jam");
//		Fnew FileReader(f).
		Interpreter i = JAM.parse("./Test");
		i.run();
	}
}
