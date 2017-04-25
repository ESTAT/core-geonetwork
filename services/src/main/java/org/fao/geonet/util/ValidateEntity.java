/*
 * Copyright (C) 2001-2016 Food and Agriculture Organization of the
 * United Nations (FAO-UN), United Nations World Food Programme (WFP)
 * and United Nations Environment Programme (UNEP)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 *
 * Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
 * Rome - Italy. email: geonetwork@osgeo.org
 */
package org.fao.geonet.util;

import org.apache.commons.lang.StringUtils;
import org.fao.geonet.exceptions.BadFormatEx;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.Set;

/**
 * JSR 303 validation of entities.
 *
 * Used in controllers to validated db entities before storing in the database.
 *
 * If any validation error a @see org.fao.geonet.exceptions.BadFormatEx() exception is thrown.
 *
 * @author Jose García
 *
 * @param <T>
 */
public class ValidateEntity<T> {

    public void check(T entity) {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        final Validator validator = factory.getValidator();

        Set<ConstraintViolation<T>> constraintViolations = validator.validate(entity);

        if (!constraintViolations.isEmpty()) {
            String message = "";
            for (ConstraintViolation<T> violation : constraintViolations) {
                if (StringUtils.isEmpty(message)) {
                    message += violation.getMessage();
                } else {
                    message += ", " + violation.getMessage() ;
                }
            }

            throw new BadFormatEx(message);
        }
    }
}
