import type { ValidationAcceptor, ValidationChecks } from 'langium';
import type { RbotAstType, Person } from './generated/ast.js';
import type { RbotServices } from './rbot-module.js';

/**
 * Register custom validation checks.
 */
export function registerValidationChecks(services: RbotServices) {
    const registry = services.validation.ValidationRegistry;
    const validator = services.validation.RbotValidator;
    const checks: ValidationChecks<RbotAstType> = {
        Person: validator.checkPersonStartsWithCapital
    };
    registry.register(checks, validator);
}

/**
 * Implementation of custom validations.
 */
export class RbotValidator {

    checkPersonStartsWithCapital(person: Person, accept: ValidationAcceptor): void {
        if (person.name) {
            const firstChar = person.name.substring(0, 1);
            if (firstChar.toUpperCase() !== firstChar) {
                accept('warning', 'Person name should start with a capital.', { node: person, property: 'name' });
            }
        }
    }

}
