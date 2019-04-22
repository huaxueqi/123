package com.util;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

public class Util {
	/**
	 * 利用反射机制在两个对象之间进行相同属性值拷贝
	 * 
	 * @param source
	 * @param target
	 * @param except
	 *            拷贝时排除的字段
	 */
	public static void copyproperties(Object source, Object target, String... except) {
		Field fields[] = source.getClass().getDeclaredFields();
		List<String> eccepts = Arrays.asList(except);

		String name = "";
		Object value = null;

		for (Field f : fields) {
			try {
				f.setAccessible(true);
				name = f.getName();
				value = f.get(source);
				if (value == null) continue;
				if (eccepts.contains(name)) continue;

				Field field = target.getClass().getDeclaredField(name);
				if (field != null) {
					field.setAccessible(true);
					field.set(target, value);
				}
			} catch (Exception e) {
			}
		}
	}
}
